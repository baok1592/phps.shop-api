<?php

namespace app\api\validate;


class IDPostiveInt extends BaseValidate
{
    protected $rule = [
        'id' => 'require|isPositiveInteger',
    ];
    protected $message  =   [
        'id.require' => 'ID不能为空',
        'id.isPositiveInteger'     => 'ID必须是正整数'
    ];
}
