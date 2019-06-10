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
use think\facade\Log;

class UserAddress extends BaseModel
{
    protected $hidden = ['create_time','update_time','user_id'];

    //删除地址
    public static function address_del($id,$uid)
    {
        $res = self::where(['id'=>$id,'user_id'=>$uid])->delete();
        if(!$res){
            throw new BaseException(['删除错误']);
        }else{
            return json(new SuccessMessage(),201);
        }
    }

    //获取指定地址
    public static function getAddressOne($id,$uid)
    {
        $data = self::where(['id'=>$id,'user_id'=>$uid])->find();
        if(!$data){
            throw new BaseException(['msg'=>'地址不存在']);
        }
        return $data;
    }

    //创建用户地址
    public static function CreateOne($uid,$post)
    {
        $AddressModel=new UserAddress;
        $count= $AddressModel->where('user_id',$uid)->count();
        if ($count>=5){
            throw new BaseException(['msg'=>'最多只能创建5个地址']);
        }else{
            Db::startTrans();
            try {
                $post['user_id'] = $uid;
                $post['is_default'] = 1;

                Log::error(json_encode($post));
                $AddressModel->save($post); //直接通过关联模型来新增
                self::setOnlyAddress($AddressModel->id,$AddressModel->user_id);//将指定地址设为唯一
                Db::commit();
            }catch (\Exception $e) {
                Db::rollback();// 回滚事务
                throw new BaseException(['msg'=>'新增地址失败']);
            }
            return json(new SuccessMessage(), 201);
        }
    }

    //将指定地址设为唯一
    public static function setOnlyAddress($id,$uid)
    {
        self::where("user_id",$uid)->where("id","<>",$id)->update(["is_default"=>0]);
        return self::where("user_id",$uid)->where("id",$id)->update(["is_default"=>1]);
    }

}