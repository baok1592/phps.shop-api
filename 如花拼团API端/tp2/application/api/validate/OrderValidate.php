<?php

namespace app\api\validate;


class OrderValidate extends BaseValidate
{
    protected $rule = [
        'goods_id' => 'require|isPositiveInteger',
        'number' => 'require|isPositiveInteger',  //数量
        'price' => 'require|isNotEmpty', //单价
        'type' => 'require|isNotEmpty', //拼团还是单独(only)购买
        'order_from' => 'require', //订单来源,0:小程序,1:wap
        'payment_type' => 'require', //支付方式 wx
        'shipping_money' => 'require',  //订单运费
        'sku_id' => 'isPositiveInteger',  //地址ID
        'sku_name' => 'max:200',  //地址ID
        'msg' => 'chsAlphaNum',  //地址ID
        'total'=> 'require'

    ];
}
