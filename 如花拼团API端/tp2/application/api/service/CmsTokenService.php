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
use app\api\model\Admins as AdminsModel;
use app\api\model\SysConfig as SysConfigModel;
use app\lib\enum\ScopeEnum;
use app\lib\exception\AdminException;
use app\lib\exception\BaseException;
use app\api\model\User as UserModel;
use app\lib\exception\SuccessMessage;
use think\Exception;
use think\facade\Request;
use app\api\model\Group as GroupModel;
//管理后台的Token
class CmsTokenService extends TokenService
{

    //注册管理员
    public static function register($post)
    {
        $user = AdminsModel::where('username',$post['username'])->find();
        if($user){
            throw new AdminException(['msg'=>'用户名已存在']);
        }

        $data['username'] = $post['username'];
        $data['password'] = password($post['password']);
        $data['group_id'] = $post['gid'];
        $data['description'] = $post['description'];
        $res = AdminsModel::create($data);
        if($res){
            return 1;
        }else{
            throw new AdminException(['msg'=>'注册失败']);
        }
    }

    //登陆，并返回token
    public function loginService($user,$pwd){
        $password = password($pwd);    //common文件的函数
        $where['username']=$user;
        $where['password']=$password;
        $user = AdminsModel::where($where)->find();
        if(!$user){
        	throw new AdminException();
        } 
        if($user->state == 1){
            throw new AdminException(['msg'=>'已禁用']);
        }
        $cachedValue = $this->setWxCache($user->username,$user->id);
        $res['token'] = $this->saveCache($cachedValue);
        $oauth=GroupModel::where('id',$user->group_id)->value('oauth');
        $res['oauth']=explode(',',$oauth);
        return json($res);
    }

    //组合uid，username，权限
    private function setWxCache($name, $gid){
        $cache['admin_id'] = $gid;
        $cache['username'] = $name;
        $cache['scope'] = ScopeEnum::Root;  // scope=16 代表App用户的权限数值
        return $cache;
    }



    //修改密码
    public static function editAdminPwd($form)
    {
        $aid = TokenService::getCurrentAid();
        $admin = AdminsModel::get($aid);
        if(!$admin){
            throw new AdminException(['msg'=>'用户信息错误']);
        }
        if($admin->password != password($form['old_password'])){
            throw new AdminException(['msg'=>'原密码错误']);
        }
        $admin->password=password($form['password']);
        $res = $admin->save();
        if(!$res){
            throw new AdminException(['msg'=>'修改密码失败']);
        }
        return json((new SuccessMessage),201);
    }








}