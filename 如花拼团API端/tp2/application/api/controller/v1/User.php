<?php
/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087
 */

namespace app\api\controller\v1;
use app\api\model\User as UserModel;
use app\api\service\TokenService;
use app\api\validate\IDPostiveInt;
use think\facade\Log;

class User extends Base
{

    //获取所有用户
    public function getUserAll($page=1, $size = 10)
    {
        $key = $this->request->param('keywords')?:'';
        if (isset($key) and !empty($key)) {
            $key = trim($key);
            $num = UserModel::where('mobile','like','%'.$key.'%')->count();
        }else{
            $num = UserModel::count();
        }
        $pagingOrders =  UserModel::getUserByPage($page,$size,$key);
        if ($pagingOrders->isEmpty())
        {
            $data = [
                'current_page' => 1,
                'data' => [],
                'total' => $num
            ];
        }else {
            $data = $pagingOrders->toArray();
            $data['total'] = $num;
        }
        return json($data,201);
    }

    //获取指定用户详细
    public function GetUserInfo($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=UserModel::getInfo($id);
        return $data;
    }

    //用户授权更新头像昵称
    public function register()
    {
        $uid = TokenService::getCurrentUid();

        Log::error(json_encode(input('post.')));
        return UserModel::upNickname($uid,input('post.'));
    }
}