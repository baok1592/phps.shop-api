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

class Article extends BaseModel
{
    protected $table = 'qy_article';
    protected $hidden = ['publisher_name'];

    public static function getListAll($show='')
    {
        if($show=='') {
            $data = self::where('is_hidden', 0)->select();
        }else{
            $data = self::all();
        }
        if(!$data){
            throw new BaseException(['msg'=>'获取文章失败']);
        }
        return $data;
    }

    public static function getNewsByID($id)
    {
        $data = self::get($id);
        if(!$data){
            throw new BaseException(['msg'=>'获取文章失败']);
        }
        return $data;
    }

    public function getIsHiddenAttr($v)
    {
        return $v==1 ? true : false;
    }
}