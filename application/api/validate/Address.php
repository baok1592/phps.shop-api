<?php

namespace app\api\validate;


class Address extends BaseValidate
{
    protected $rule = [
        'name' => 'require|isNotEmpty',
        'mobile' => 'require|isMobile',
        'province' => 'require|isNotEmpty', //省
        'city' => 'require|isNotEmpty', //市
        'country' => 'require|isNotEmpty', //区域
        'detail' => 'require|isNotEmpty', //详细
    ];

    protected $message = [
      'mobile.isMobile' => "手机号输入有误",
      'city' => "地区填写有误"
    ];
}
