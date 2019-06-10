<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace app\api\service;

use app\api\model\User as UserModel;
use app\api\model\UserAddress;
use app\lib\exception\BaseException;
use think\Request;

class UserService
{
    public static function getUserInfo($uid,$address_id='')
    {

        $data=[];
        $data['user_ip'] = (new Request)->ip(); //买家IP
        $info=UserModel::get($uid);
        $data['user_name']=$info->nickname;   //买家名称
        $data['user_id']=$uid;  //买家id
        //$address=UserAddress::where('user_id',$uid)->find($address_id);
        $address=UserAddress::where('user_id',$uid)->where('is_default',1)->find();
        if(!$address){
            throw new BaseException(['msg'=>'地址错误']);
        }
        $data['receiver_name'] = $address['name'];
        $data['receiver_mobile'] = $address['mobile'];
        //$data['receiver_province'] = $address['province'];
        //$data['receiver_district'] = $address['country'];
        $data['receiver_city'] = $address['city'];
        $data['receiver_address'] = $address['detail'];
        return $data;
    }
}