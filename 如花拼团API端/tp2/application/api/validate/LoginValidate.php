<?php

namespace app\api\validate;


class LoginValidate extends BaseValidate
{
    protected $rule = [
        'username'=> 'require|alphaDash|max:30',
        'password'=> 'require|alphaDash|min:6',
    ];

    protected $message = [
        'username' => "账号格式错误",
        'password' => "密码格式错误",
        'password.min' => "密码不小于6位",
    ];

}