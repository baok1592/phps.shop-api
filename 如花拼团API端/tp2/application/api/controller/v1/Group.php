<?php


namespace app\api\controller\v1;

use app\api\validate\IDPostiveInt;
use app\lib\exception\BaseException;
use think\Validate;
use app\api\model\Group as GroupModel;


class Group extends Base
{
    public function add()
    {
        $validate = Validate::make([
            'name'  => 'require|max:255',
            'res' => 'require'
        ]);
        if (!$validate->check(input('post.'))) {
            $msg=$validate->getError();
            throw new BaseException(['msg'=>$msg]);
        }
        $data['name']=input('post.name');
        $data['oauth']=implode(',',input('post.res'));
        $res=GroupModel::create($data);
        return $res?1:0;
    }

    public function edit()
    {
        $validate = Validate::make([
            'id'=>'require|number',
            'name'  => 'require|max:255',
            'res' => 'require'
        ]);
        if (!$validate->check(input('post.'))) {
            $msg=$validate->getError();
            throw new BaseException(['msg'=>$msg]);
        }
        $id=input('post.id');
        $data['name']=input('post.name');
        $data['oauth']=implode(',',input('post.res'));
        $group=GroupModel::get($id);
        $res=$group->save($data);
        return $res?1:0;
    }

    //cms 删除
    public function del($id)
    {
        (new IDPostiveInt)->goCheck();
        $result = GroupModel::destroy($id);
        return $result?1:0;
    }

    public function getall()
    {
        $res=GroupModel::field('oauth',true)->all();
        if(!$res){
            return null;
        }
        return $res;
    }

    public function getone($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = GroupModel::get($id);
        if(!$data){
            return 0;
        }
        $data['oauth'] = explode(',',$data['oauth']);
        return json($data,201);
    }
}