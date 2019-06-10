<?php

namespace app\api\validate;


class AddressUp extends BaseValidate
{
    protected $rule = [
        'id' => 'require|isPositiveInteger',
        'name' => 'require|isNotEmpty',
        'mobile' => 'require|isMobile',
        'city' => 'require|isNotEmpty', //市
        'detail' => 'require|isNotEmpty', //详细
    ];
}
