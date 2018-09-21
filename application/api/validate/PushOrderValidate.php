<?php

namespace app\api\validate;


class PushOrderValidate extends BaseValidate
{
    protected $rule = [
        'goods_id' => 'require|isPositiveInteger',
        'number' => 'require|isPositiveInteger',  //数量
        'price' => 'require|isNotEmpty', //单价
        'order_from' => 'require', //订单来源,0:小程序,1:wap
        'payment_type' => 'require', //支付方式 wx
        'shipping_money' => 'require',  //订单运费
        'address_id' => 'require',  //地址ID
        'item_id'  => 'require'
    ];
}
