<?php
namespace app\api\controller\v1;

use app\api\model\Admins;
use app\api\service\CmsTokenService;
use app\api\validate\IDPostiveInt;
use app\api\validate\RegisterValidate;
use app\lib\exception\AdminException;
use app\lib\exception\BaseException;
use think\Validate;
use app\api\model\Admins as AdminsModel;


class Cms extends Base
{
    //修改密码
    public function edit_password()
    {
        $validate = Validate::make([
            'password'=> 'require|alphaDash|min:6',
            'old_password'=> 'require|alphaDash|min:6'
        ]);
        $form = input('param.');
        if (!$validate->check($form)) {
            throw new AdminException(['msg'=>$validate->getError()]);
        }
        return CmsTokenService::editAdminPwd($form);
    }

    //更新某管理员
    public function edit()
    {
        $validate = Validate::make([
            'id'=> 'require|number',
            'gid'=> 'require|number',
        ]);
        $form = input('param.');
        if (!$validate->check($form)) {
            throw new AdminException(['msg'=>$validate->getError()]);
        }

        $id = input('param.id');
        $data['group_id'] = input('param.gid');
        $data['description'] = input('param.description');

        $res=AdminsModel::where('id',$id)->update($data);
        return $res?1:0;

    }
    //增加管理员
    public function add_admin()
    {
        (new RegisterValidate)->goCheck();
        return CmsTokenService::register(input('post.'));
    }

    //获取所有管理员
    public function GetAdminAll()
    {
        $res = AdminsModel::all();
        if(!$res){
            throw new AdminException(['msg'=>'获取失败']);
        }
        return $res;
    }

    //删除管理员
    public function del_admin($id)
    {
        (new IDPostiveInt)->goCheck();
        if($id<=1){
            throw new BaseException(['msg'=>'不能删除最高管理员']);
        }
        $res = AdminsModel::destroy($id);
        if(!$res){
            throw new BaseException(['msg'=>'删除失败']);
        }else{
            return 1;
        }
    }
}
