<?php

namespace app\api\validate;


class NameValidate extends BaseValidate
{
    protected $rule = [
        'name' => 'require|max:10',
    ];
}
