<?php

/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */
namespace app\http\middleware;

//中间件，验证token，检测权限
use app\api\service\TokenService;

class CheckCms
{
    public function handle($request, \Closure $next)
    {
        $res = TokenService::GTadmimScope();//判断是否具有管理员权限
        if($res == true) {
            return $next($request);
        }
    }
}