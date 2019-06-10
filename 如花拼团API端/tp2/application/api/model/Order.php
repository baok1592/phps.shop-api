<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace app\api\model;


use app\lib\exception\BaseException;
use app\lib\exception\SuccessMessage;
use think\Db;
use think\model\concern\SoftDelete;
use think\Request;

class Order extends BaseModel
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    protected $hidden = ['delete_time'];

    //关联规格模型
    public function sku()
    {
        return $this->hasMany('GoodsSku','goods_id','goods_id');
    }

    //关联订单商品模型
    public function ordergoods()
    {
        return $this->hasMany('OrderGoods','order_id','order_id');
    }
    //关联模型
    public function rate()
    {
        return $this->belongsTo('Rate','rate_id','id');
    }
    //关联图片
    public function imgs()
    {
        return $this->belongsTo('Image','goods_picture','id');
    }

    //关联团单
    public function item()
    {
        return $this->belongsTo('item','item_id','id');
    }

    public function setImgsAttr($v)
    {
        return $v['url'];
    }
    
    //获取指定团单下所有订单的购买者id
    public static function getOneItemUsers($post)
    {
        $data=self::where(['item_id'=>$post['item_id'],'goods_id'=>$post['goods_id']])->column('user_id');
        if(!$data){
            throw new BaseException(['msg'=>'获取团单下订单信息错误']);
        }
        return $data;
    }

    //获取订单指定字段
    public static function getOrderAttr($id,$field)
    {
        $value = self::where('order_id',$id)->value($field);
        if(!$value){
            throw new BaseException(['获取字段失败']);
        }
        return $value;
    }

    //获取所有订单，包含分页
    public static function getOrderByPage($page=1, $size=10,$key=''){
        if(!empty($key)){
            $pagingData = self::with('ordergoods')->where('order_num','like','%'.$key.'%')->order('create_time desc')
                ->field('delete_time,update_time,shipping_money,goods_id,user_ip', true)
                ->paginate($size, true, ['page' => $page]);
        }else {
            $pagingData = self::with('ordergoods')->order('create_time desc')->field('delete_time,update_time,shipping_money,goods_id,user_ip', true)
                ->paginate($size, true, ['page' => $page]);
        }
        return $pagingData ;
    }

    public static function up_courire_model($param)
    {
        $pay=self::where('order_id',$param['order_id'])->value('pay_status');
        if($pay!=1) {
            throw new BaseException(['msg'=>'未支付的订单无法发货']);
        }
        Db::startTrans();
        try {
            $courier['courier'] = $param['courier'];
            $courier['courier_num']=$param['courier_num'];
            $courier['drive_status'] = 1;
            self::where('order_id',$param['order_id'])->Update($courier);

            $save['order_id'] = $param['order_id'];
            $save['type_name']='录入快递单号';
            $save['content']=$param['courier'].'，'.$param['courier_num'];
            OrderLog::create($save);
            Db::commit();
            return true;
        }catch (\Exception $e) {
            Db::rollback();// 回滚事务
            throw new BaseException(['msg'=>'快递信息录入失败']);
        }
    }

    public static function up_remark_model($param)
    {
        Db::startTrans();
        try {
            self::where('order_id', $param['order_id'])->Update(['remark' => $param['remark']]);
            $save['order_id'] = $param['order_id'];
            $save['type_name']='添加备注';
            $save['content']=$param['remark'];
            OrderLog::create($save);
            Db::commit();
            return true;
        }catch (\Exception $e) {
            Db::rollback();// 回滚事务
            throw new BaseException(['msg'=>'备注信息录入失败']);
        }
    }

    public static function edit_price_model($param)
    {
        Db::startTrans();
        try {
            self::where('order_id', $param['order_id'])->Update(['edit_money' => $param['price'],'order_money'=>$param['price']]);
            $save['order_id'] = $param['order_id'];
            $save['type_name']='修改订单金额';
            $save['content']=$param['price'];
            OrderLog::create($save);
            Db::commit();
            return true;
        }catch (\Exception $e) {
            Db::rollback();// 回滚事务
            throw new BaseException(['msg'=>'备注信息录入失败']);
        }
    }
}