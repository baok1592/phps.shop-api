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
use app\api\model\SysConfig as SysConfigModel;
use app\lib\enum\ScopeEnum;
use app\lib\exception\BaseException;
use app\api\model\User as UserModel;
use think\Exception;

//小程序+公众号Token
class WxTokenService extends TokenService
{
    protected $code;
    protected $wxAppID;
    protected $wxAppSecret;
    protected $wxExpire;
    protected $wxLoginUrl;

    function __construct($code)
    {
        $wxconfig=$this->wxconfig();
        $this->code = $code;
        $this->wxAppID = $wxconfig['wx_app_id'];
        $this->wxAppSecret = $wxconfig['wx_app_secret'];
        //sprintf函数是把百分号（%）符号替换成一个作为参数进行传递的变量：%s=字符串,%u=正整数
        $this->wxLoginUrl = sprintf(config('setting.wx_login_url'),$this->wxAppID,
            $this->wxAppSecret, $this->code);
    }
    //获取token，openid
    public function getToken()
    {
        //注意code是临时的，所以向微信服务器提交只能使用一次
        $result = curl_get($this->wxLoginUrl);
        $wxResult = json_decode($result, true);
        if (empty($wxResult))
        {
            throw new Exception('获取session_key及openID时异常，微信内部错误');
        }else{
            $loginFail = array_key_exists('errcode', $wxResult);
            if ($loginFail) {
                $this->WxError($wxResult);
            } else {
                return $this->grantToken($wxResult);
            }
        }
    }
    //openid，uid放入缓存，$token做缓存键名;
    private function grantToken($wxResult){
        $openid = $wxResult['openid'];
        $user = UserModel::getByOpenID($openid);
        if($user>0){
            $uid = $user;
        } else{
            $uid = $this->newUser($openid);
        }
        $cachedValue = $this->setWxCache($wxResult,$uid);
        $token = $this->saveCache($cachedValue);
        return $token;
    }
    //组合uid，openid，权限
    private function setWxCache($wxResult, $uid){
        $cache = $wxResult; //微信的3个返回值
        $cache['uid'] = $uid;
        $cache['scope'] = ScopeEnum::User;  // scope=16 代表App用户的权限数值
        return $cache;
    }

    private function newUser($openid){
        $user = UserModel::create([
            'openid' => $openid
        ]);
        return $user->id;
    }


    //微信错误信息解析后抛出
    private function WxError($wxResult)
    {
        throw new BaseException(
            [
                'msg' => $wxResult['errmsg'],
                'errorCode' => $wxResult['errcode']
            ]);
    }

    //从数据库获取小程序配置信息
    public function wxconfig()
    {
        $where['is_use']=1;
        $where['key']=['wx_app_id','wx_app_secret','wx_token_expire'];
        $data = SysConfigModel::where($where)->select();
        if(!$data || count($data)<1){
            throw new BaseException(['msg'=>'API中无小程序配置信息']);
        }
        $arr=[];
        foreach ($data as $k=>$v){
            $arr[$v['key']] = $v['value'];
        }
        return $arr;
    }


}