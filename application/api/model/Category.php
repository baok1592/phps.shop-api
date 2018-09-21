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

class Category extends BaseModel
{

    //关联图片
    public function imgs()
    {
        return $this->belongsTo('Image','category_pic','id');
    }

    public static function getCategoryAll($vs=false)
    {
        $data=self::with('imgs')->where('is_visible',1)->order('sort asc')->select();
        if($vs){
            $data=self::with('imgs')->order('sort asc')->select();
        }

        if(!$data || count($data)<1){
            throw new BaseException(['msg'=>'获取商品分类失败或无数据']);
        }
        return $data;
    }
    public static function getCategoryLevel($id)
    {
        $where['level']=$id;
        $where['is_visible'] = 1;
        $data=self::with('imgs')->where($where)->order('sort asc')->select();
        if(!$data || count($data)<1){
            throw new BaseException(['msg'=>'获取商品分类失败或无数据']);
        }
        return $data;
    }

    public function setImgsAttr($v)
    {
        return $v['url'];
    }
}