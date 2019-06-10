<?php

namespace app\api\controller\v1;


use app\api\service\WxNotifyService as WxNotify;
use app\api\validate\IDPostiveInt;
use app\api\service\PayService;
use think\facade\Log;

class Pay extends Base
{
    //获取调用小程序支付，必须的数据
    public function getPreOrder($id = '')
    {
        (new IDPostiveInt)->goCheck();
        $pay = new PayService($id);
        return $pay->pay();
    }

    //小程序支付回调
    public function receiveNotify()
    {
        Log::error('小程序支付回调');
        $notify = new WxNotify();
        $notify->Handle();
    }

}