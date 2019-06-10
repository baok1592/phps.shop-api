<?php

namespace app\api\validate;


class Address extends BaseValidate
{
    protected $rule = [
        'name' => 'require|isNotEmpty',
        'mobile' => 'require|isMobile',
        'city' => 'require|isNotEmpty', //市
        'detail' => 'require|isNotEmpty', //详细
    ];

    protected $message = [
      'mobile.isMobile' => "手机号有误",
      'city' => "地区有误",
      'detail' => "详细地址有误"
    ];
}
