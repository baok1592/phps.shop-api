<?php
namespace app\api\controller\v1;

use app\api\model\UserAddress;
use app\api\service\TokenService;
use app\api\validate\Address as AddressValidate;
use app\api\validate\AddressUp as AddressUpValidate;
use app\api\validate\IDPostiveInt;
use app\lib\exception\BaseException;
use app\lib\exception\SuccessMessage;

//用户地址类
class Address extends Base
{
    //TP5的前置方法
    protected $beforeActionList = [
        //'checkScope' => ['only' => 'createOrUpdateAddress']
        'checkScope'
    ];
    // 创建用户地址
    /*【当前模式是1人只能有1个地址】
       * 1、验证字段
       * 2、根据Token来获取uid
       * 3、根据uid来查找用户数据，判断用户是否存在，如果不存在抛出异常。
       * 4、获取用户从客户端提交来的地址信息，并过滤非验证器中的字段
       * 6、新增后成功返回
       */
    public function CreateAddress()
    {
        $validate = new AddressValidate();
        $validate->goCheck();

        $uid = TokenService::getCurrentUid();//接收token，获取uid
        $post = $validate->getDataByRule(input('post.'));//过滤非验证器中的字段
        return UserAddress::CreateOne($uid,$post);
    }

    //获取用户所有地址
    public function getUserAddress()
    {
        $uid = TokenService::getCurrentUid();//接收token，获取uid
        $data= (new UserAddress)->where('user_id',$uid)->select();
        if(!$data){
            throw new BaseException(['msg'=>'获取用户地址失败']);
        }
        return $data;
    }

    //删除指定地址
    public function DelAddress($id='')
    {
        (new IDPostiveInt)->goCheck();
        $uid=TokenService::getCurrentUid();
        return UserAddress::address_del($id,$uid);
    }

    //获取指定地址
    public function getAddressByID($id='')
    {
        (new IDPostiveInt)->goCheck();
        $uid=TokenService::getCurrentUid();
        return UserAddress::getAddressOne($id,$uid);
    }

    //更新指定地址
    public function UpdateAddress()
    {
        (new IDPostiveInt)->goCheck();
        $validate = new AddressUpValidate();
        $validate->goCheck();
        $data = $validate->getDataByRule(input('post.'));//过滤非验证器中的字段
        $data['user_id'] = TokenService::getCurrentUid();//接收token，获取uid
        $one_address=UserAddress::getAddressOne($data['id'],$data['user_id']);
        if(!$one_address){
            throw new BaseException(['msg'=>'地址不存在']);
        }
        $res=UserAddress::update($data);
        if(!$res){
            throw new BaseException(['msg'=>'更新失败']);
        }
        return json(new SuccessMessage(), 201);
    }

    //获取用户默认地址
    public function getAddressDefault()
    {
        $uid=TokenService::getCurrentUid();
        $res = UserAddress::where(['is_default'=>'1','user_id'=>$uid])->find();
        if(!$res){
            return json([],201);
        }
        return $res;
    }

    //将用户指定地址设为默认
    public function setUserAddressDefault($id="")
    {
        (new IDPostiveInt)->goCheck();
        $uid=TokenService::getCurrentUid();
        $res = UserAddress::setOnlyAddress($id,$uid);
        if(!$res){
            throw new BaseException(['msg'=>'默认地址设置失败']);
        }
        return json(new SuccessMessage(), 201);
    }
}
