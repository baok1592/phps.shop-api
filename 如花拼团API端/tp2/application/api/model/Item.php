<?php
namespace app\api\model;

use app\lib\exception\BaseException;
use think\model\concern\SoftDelete;

class Item extends BaseModel
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    protected $hidden = ['delete_time'];

    //团单关联订单
    public function orders()
    {
        return $this->hasMany('Order','item_id','id');
    }
   //关联
    public function user()
    {
        return $this->belongsTo('User','operator_id','id');
    }
    //获取某商品待参团的团单
    public static function getItemByHalf($goods_id)
    {        
        $item_expire = SysConfig::where('key','item_expire')->value('value');
        $sj_time=time()-$item_expire;
        $data=self::with(['orders','user'=>function($q){
            $q->field('id,nickname,headpic');
        }])->where(['goods_id'=>$goods_id,'item_status'=>2])->where('create_time','>',$sj_time)->limit('3')->order('id desc')->select();
        foreach ($data as $k=>$v){
            if(count($v['orders'])>=1) {
                $data[$k]['into_people'] = count($v['orders']); //获取已参团人数
                $data[$k]['gq_time']= strtotime($v['create_time']) + $item_expire;
            }else{
                throw new BaseException(['msg'=>'获取参团人数错误']);
            }
            unset($data[$k]['orders']); 
        }
        return $data;
    }


    //某团单，起团人数
    public static function getItemPeople($item_id)
    {
        return self::where(['id'=>$item_id])->value('item_people');
    }

    //检测某商品所有团单，是否有已支付、未满人、已超时的，将这些团单状态改为过期
    public static function checkItemExpire($goods_id)
    {
        $item_arr = self::where(['goods_id'=>$goods_id,'item_status'=>1])->select();
        $expire_arr = [];
        $item_expire = SysConfig::where('key','item_expire')->value('value');
        foreach ($item_arr as $k=>$v){
            $Expire = strtotime($v['create_time']) + $item_expire;
            if(($Expire - time()) < 0) {
                $expire_arr[] = $v['id']; //过期团单ID
            }
        }
        if(count($expire_arr) > 0){
            $str = implode(",",$expire_arr);
            $res = self::where('id','in',$str)->update(['item_status'=>0]);
            if(!$res){
                throw new BaseException(['团单过期更新失败']);
            }
            return true;
        }
    }

    //获取团单详细
    public static function getItemByPage($page=1, $size=10){
        $pagingData = self::with(['orders'=>function($query){
            $query->field('item_id,order_num,goods_picture,num,pay_status,price,order_money,create_item');
        }])->order('create_time desc')->paginate($size, true, ['page' => $page]);
        return $pagingData;
    }

    public function getUpdateTimeAttr($v)
    {
        return $v;
    }
    public function getCreateTimeAttr($v)
    {
        return date("Y-m-d H:i",$v);
    }
}
