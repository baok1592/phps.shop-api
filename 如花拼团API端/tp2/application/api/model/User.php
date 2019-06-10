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

class User extends BaseModel
{
    protected $hidden = [''];

    //根据用户openid获取uid
    public static function getByOpenID($openid)
    {
        return self::where('openid',$openid)->value('id');
    }

    //用户授权更新头像昵称
    public static function upNickname($uid,$data)
    {
        if(!empty($data['nickname']) && !empty($data['headpic'])){
            $res = self::where('id',$uid)->update(['nickname'=>$data['nickname'],'headpic'=>$data['headpic']]);
            if($res){
                return json((new SuccessMessage),201);
            }
        }
        throw new BaseException(['msg'=>'更新失败']);
    }

    //获取指定用户详细信息
    public static function getInfo($id)
    {
        //关联查询+条件
        return self::with(['address'=>function($query){
            $query->where('select',1)->field('user_id,province,city');
        }])->find($id);
    }

    //关联地址
    public function address()
    {
        return $this->hasMany('UserAddress','user_id','id');
    }

    public function getIsVisibleAttr($v)
    {
        return $v==1 ? true : false;
    }

    //获取所有用户，包含分页
    public static function getUserByPage($page=1, $size=10,$key=''){
        if(!empty($key)){
            $pagingData = self::order('create_time desc')->where('mobile','like','%'.$key.'%')
              ->field('update_time,start,password',true)->paginate($size, true, ['page' => $page]);
        }else{
            $pagingData = self::order('create_time desc')->field('update_time,start,password',true)
                ->paginate($size, true, ['page' => $page]);
        }
        return $pagingData ;
    }

}