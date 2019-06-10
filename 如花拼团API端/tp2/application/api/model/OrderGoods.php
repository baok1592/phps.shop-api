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

class OrderGoods extends BaseModel
{
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    protected $hidden = ['delete_time'];

    //关联订单商品模型
//    public function orders()
//    {
//        return $this->belongsTo('Order','order_id','order_id');
//    }

//    //关联规格模型
//    public function sku()
//    {
//        return $this->hasMany('GoodsSku','goods_id','goods_id');
//    }
//
    //关联图片
    public function imgs()
    {
        return $this->belongsTo('Image','pic_id','id');
    }
//
//    //关联团单
//    public function item()
//    {
//        return $this->belongsTo('item','item_id','id');
//    }
//
//    public function setImgsAttr($v)
//    {
//        return $v['url'];
//    }
    

}