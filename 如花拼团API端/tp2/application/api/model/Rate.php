<?php


namespace app\api\model;


use think\Model;

class Rate extends Model
{
    public function getCreateTimeAttr($v)
    {
        return date("Y-m-d",$v);
    }

    public function user()
    {
        return $this->belongsTo('User','user_id','id');
    } 
}