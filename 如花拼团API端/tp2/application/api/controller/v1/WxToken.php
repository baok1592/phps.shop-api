<?php
/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087
 */
namespace app\api\controller\v1;

use app\api\service\WxTokenService;
use app\api\validate\TokenValidate;
use app\lib\exception\BaseException;
use app\api\service\TokenService;
//Token类
class WxToken extends Base
{
    /*
     * 用途：将“openid，uid，权限”存入缓存value，生成一个token做缓存的key并返回
     * 1、获取code
     * 2、组合code,Appid与Secret生成URL，
     * 3、curl方式向微信服务器提交，获取openid;注意一个code只能使用一次
     * 4、判断openid，数据库不存在则写入；从数据库获取该openid的用户UID
     * 5、生成token，token是一个随机字符串，它是缓存的key；将“openid，uid，权限”存入缓存value
     * 6、返回token
     */
    public function getToken($code='')
    {
        (new TokenValidate)->goCheck();
        $usertoken=new WxTokenService($code);
        $token=$usertoken->getToken();
        $data = ['token'=>$token];
        return json($data);
    }

    //验证token，返回false,true
    public function verifyToken($token='')
    {
        if(!$token){
            throw new BaseException([
                'token不允许为空'
            ]);
        }
        $valid = TokenService::verifyToken($token);
        $arr=['isValid' => $valid];
        return json($arr);
    }

}
