<?php
namespace app\api\controller;


class Error
{
    public function _empty()
    {
        $res =[
            "code"=>"400",
            "msg"=>"访问页面不存在",
            "errorCode"=>"10000"
        ];
        return json($res,400);
    }
}