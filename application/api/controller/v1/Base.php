<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */
namespace app\api\controller\v1;

use app\api\service\TokenService;
use think\Controller;

class Base extends Controller
{
	public function _empty()
    {
        $res =[
            "code"=>"400",
            "msg"=>"访问页面不存在",
            "errorCode"=>"10001"
        ];
        return json($res);
    }
    
    //判断用户权限
    protected function checkScope()
    {
        TokenService::GTuserScope();//通过token从缓存中获取用户scope，并判断是否有权限
    }

}
