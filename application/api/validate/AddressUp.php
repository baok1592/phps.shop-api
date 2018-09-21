<?php

namespace app\api\validate;


class AddressUp extends BaseValidate
{
    protected $rule = [
        'id' => 'require|isPositiveInteger',
        'name' => 'require|isNotEmpty',
        'mobile' => 'require|isMobile',
        'province' => 'require|isNotEmpty', //省
        'city' => 'require|isNotEmpty', //市
        'county' => 'require|isNotEmpty', //区域
        'detail' => 'require|isNotEmpty', //详细
    ];
}
