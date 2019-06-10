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

class GoodsSku extends BaseModel{
    protected $visible=['sku_id','sku_name','market_price','price','only_price','stock','picture','imgs'];

    //关联模型
    public function imgs()
    {
        return $this->belongsTo('Image','picture','id');
    }

    /*public function setImgsAttr($v)
    {
        return $v['url'];
    }*/
}