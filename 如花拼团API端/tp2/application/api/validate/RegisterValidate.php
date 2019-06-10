<?php

namespace app\api\validate;


class RegisterValidate extends BaseValidate
{
    protected $rule = [
        'username'=> 'require|alphaDash|max:30',
        'password'=> 'require|alphaDash|min:6',
        'gid'=> 'require|isPositiveInteger'
    ];


}