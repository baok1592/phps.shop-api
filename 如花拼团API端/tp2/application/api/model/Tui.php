<?php


namespace app\api\model;


use think\Model;

class Tui extends Model
{
    protected $insert = ['status' => 0,'ip'];

    protected function setIpAttr(){
        return request()->ip();
    }
}