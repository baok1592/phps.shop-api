<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace app\api\controller\v1;
use app\api\model\SysConfig as ConfigModel;
use app\api\model\SysConfig;
use app\api\validate\ConfigValidate;
use app\lib\exception\BaseException;

class System extends Base
{
    //获取商城配置信息
    public function GetConfig($type)
    {
       $data=ConfigModel::where(['is_use'=>1,'type'=>$type])->field('id,type,value,desc')->select();
       if(!$data){
           throw new BaseException(['msg'=>'获取失败']);
       }
       return json($data);
    }

    //修改配置信息
    public function edit_config()
    {
        $post = input('post.');
        $res = (new SysConfig)->allowField(true)->saveAll($post);
        if(!$res){
            throw new BaseException(['msg'=>'修改失败']);
        }
        return 1;

    }
}