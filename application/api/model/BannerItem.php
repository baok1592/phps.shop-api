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


class BannerItem extends BaseModel
{
    protected $hidden = ['update_time','delete_time','banner_id','img_id'];

    public function imgs()
    {
        return $this->belongsTo('Image','img_id','id');
    }
    public function banner()
    {
        return $this->belongsTo('Banner','banner_id','id');
    }
    public function setImgsAttr($v)
    {
        return $v['url'];
    }
}