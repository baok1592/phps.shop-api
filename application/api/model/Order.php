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
use think\model\concern\SoftDelete;

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
            $pagingData = self::where('order_num','like','%'.$key.'%')->order('create_time desc')
                ->field('delete_time,update_time,shipping_money,goods_id,user_ip', true)
                ->paginate($size, true, ['page' => $page]);
        }else {
            $pagingData = self::order('create_time desc')->field('delete_time,update_time,shipping_money,goods_id,user_ip', true)
                ->paginate($size, true, ['page' => $page]);
        }

        return $pagingData ;
    }
}