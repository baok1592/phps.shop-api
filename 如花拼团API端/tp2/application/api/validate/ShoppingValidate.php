<?php

namespace app\api\validate;


class ShoppingValidate extends BaseValidate
{
    protected $rule = [

        'type' => 'require|isNotEmpty', //拼团还是单独(only)购买
        'order_from' => 'require', //订单来源,0:小程序,1:wap
        'payment_type' => 'require', //支付方式 wx
        'shipping_money' => 'require',  //订单运费
        'msg' => 'chsAlphaNum',  //地址ID
        'total'=> 'require',
        'json'=>'require'

    ];
}
