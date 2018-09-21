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

class Shop extends BaseModel
{
    protected $hidden = ['uid','shop_type','shop_group_id','shop_sort','shop_close_info',
        'end_time','shop_state','shop_recommend','create_time'];

    public static function getShopByID($id)
    {
        $data=self::with('imgs')->where('shop_state',1)->where('shop_id',$id)->find();
        if(!$data){
            throw new BaseException(['msg'=>'店铺信息不存在或已下线']);
        }
        return $data;
    }
    public function imgs()
    {
        return $this->belongsTo('Image','img_id','id');
    }
}