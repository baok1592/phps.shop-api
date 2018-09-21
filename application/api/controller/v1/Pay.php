<?php

namespace app\api\controller\v1;


use app\api\service\WxNotify;
use app\api\validate\IDPostiveInt;
use app\api\service\PayService;
use think\facade\Log;
use WxPay\WxPayNotify;

class Pay extends Base
{

    public function getPreOrder($id = '')
    {
        (new IDPostiveInt)->goCheck();
        $pay = new PayService($id);
        return $pay->pay();
    }

    public function receiveNotify()
    {
        $notify = new WxPayNotify();
        $notify->Handle();
    }
}