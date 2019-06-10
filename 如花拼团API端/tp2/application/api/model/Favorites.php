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

class Favorites extends BaseModel
{
    protected $hidden = [''];

    public static function getFavTypeByID($id,$uid,$type)
    {
        $where['type']=$type;
        $where['fav_id']=$id;
        $where['uid']=$uid;
        $count=self::where($where)->count();
        if($count<1){
            return 0;
        }
        return 1;
    }

     public static function getFavoriteByUid($uid)
    {
        $data=self::with(['product'=>function($query){
            $query->field('goods_id,goods_name,price,img_id');
        }])->where('uid',$uid)->select();
        $img=new Image();
        $api_url = SysConfig::where('key','api_url')->value('value');
        foreach ($data as $k=>$v){
            $url=$img->where('id',$v['product']['img_id'])->value('url');
            $data[$k]['imgs']=$url?$api_url.$url:'';
        }
        if(!$data){
            throw new BaseException(['msg'=>'无收藏数据或查询失败']);
        }
        $arr=[];
        foreach ($data as $k=>$v){
            if($v['type']=='goods'){
                $arr['goods'][]=$v;
            }else{
                $arr['shop'][]=$v;
            }
        }
        return $arr;
    }

    //删除地址
    public static function favorite_del($id,$uid)
    {
        $res = self::where(['fav_id'=>$id,'uid'=>$uid])->delete();
        if(!$res){
            throw new BaseException(['msg'=>'删除错误']);
        }else{
            return json(new SuccessMessage(),201);
        }
    }

    public function shopinfo()
    {
        return $this->belongsTo('Shop','fav_id','shop_id');
    }
    public function product()
    {
        return $this->belongsTo('goods','fav_id','goods_id');
    }
    public function favimg()
    {
        return $this->belongsTo('Image','img_id','id');
    }

}