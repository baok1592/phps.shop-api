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

class Banner extends BaseModel
{
    protected $hidden = ['update_time','delete_time'];

    public static function getBannerByID($id)
    {
        $data=self::with(['items','items.imgs'])->find($id);
        if(!$data){
            throw new BaseException(['msg'=>'Banner不存在']);
        }
        return $data;
    }
    public function items()
    {
        return $this->hasMany('BannerItem','banner_id','id');
    }

}