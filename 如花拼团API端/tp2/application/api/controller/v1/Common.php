<?php
namespace app\api\controller\v1;

use app\api\model\Category as CategoryModel;
use app\api\service\CmsTokenService;
use app\api\service\TokenService;
use app\api\validate\IDPostiveInt;
use app\api\model\Banner as BannerModel;
use app\api\validate\LoginValidate;
use app\api\validate\RegisterValidate;
use app\lib\exception\AdminException;
use app\lib\exception\BaseException;
use app\api\model\Image as ImageModel;
use think\facade\Log;
use Uedit\controller as Contro;

//分类
class Common extends Base
{
    //更新不同模型的布尔字段
    public function up_one($id,$db,$field)
    {
        switch ($db)
        {
            case 'order':
                 $where['order_id']=$id; break;
            case 'goods':
                $where['goods_id']=$id; break;
            case 'category':
                $where['category_id']=$id; break;
            case 'user':
                $where['id']=$id; break;
            case 'article':
                $where['id']=$id; break;
            case 'admins':
                $where['id']=$id; break;
            default:
                throw new BaseException(['msg'=>'找不到模型']);
        }
        $vs=db($db)->where($where)->value($field);
        if($vs == 0 ){
           $res = db($db)->where($where)->update([$field=>1]);
        }else{
            $res =  db($db)->where($where)->update([$field=>0]);
        }
        if($res){
            return 1;
        }else{
            return 0;
        }
    }
    
    //上传图片
    public function uploadImg($use='',$key='')
    {
        if($this->request->file('file')){
            $file = $this->request->file('file');
        }else{
            $res['code']=1;
            $res['msg']='没有上传文件';
            return json($res);
        }
        $info = $file->validate(['size'=>1*1024*1024,'ext'=>'jpg,png,gif'])->rule('date')->move('./uploads/'.$use);
        if($info) {
            //写入到附件表
            $data = [];
            $data['url'] = '/uploads/' . $use . '/' . $info->getSaveName();//文件路径
            $data['from'] = 1;
            $data['update_time'] = time();
            $data['use_name'] = $this->request->has('use') ? $this->request->param('use') : $use;//用处

            $res['id'] = (new ImageModel)->insertGetId($data);
            $res['src'] = $data['url'];
            $res['code'] = 201;
            if($key>=0){
                $res['key']=$key;
            }
            return json($res);
        } else {
            // 上传失败获取错误信息
            return json($file->getError());
        }
    }

    public function lout()
    {
        return 123;
    }
    //登陆
    public function login($username,$password)
    {
        (new LoginValidate)->goCheck();
        $res = (new CmsTokenService)->loginService($username,$password);
        return $res;
    }

    //检查是否登陆
    public function check_login()
    {
        $aid = TokenService::getCurrentAid();
        if($aid){
            return 1;
        }else{
            throw new AdminException();
        }
    }

    public function ue_uploads()
    {
        $ue=new Contro;
        $res=$ue->show();
        return $res;
    }
}
