<?php
namespace app\api\controller\v1;

use app\api\service\TokenService;
use app\api\validate\IDPostiveInt;
use app\api\model\Article as ArticleModel;
use app\lib\exception\BaseException;
use think\Validate;

//新闻类
class Article extends Base
{
    //获取所有文章
    public function getList()
    {
        if(input('get.type') == 'cms'){
            $data=ArticleModel::getListAll(1);
        }else {
            $data = ArticleModel::getListAll();
        }
        return $data;
    }
    public function edit()
    {
        $data=$this->request->param('');
        $oid=$data['oid'];
        unset($data['oid'],$data['version']);
        $res=ArticleModel::where('id',$oid)->update($data);
        return $res?1:0;
    }
    //获取某文章详情
    public function getNewsID($id)
    {
        (new IDPostiveInt)->goCheck();
        return ArticleModel::getNewsByID($id);
    }

    //添加文章
    public function add()
    {
        $validate = Validate::make([
            'title'  => 'require|chsDash',
            'content' => 'require'
        ]);
        $post = input('post.');
        if (!$validate->check($post)) {
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        $post['author'] = TokenService::getAdminName();
        $res = ArticleModel::create($post);
        if(!$res){
            throw new BaseException(['msg'=>'添加失败']);
        }
        return 1;
    }

    //删除文章
    public function del($id)
    {
        (new IDPostiveInt)->goCheck();
        $res = ArticleModel::destroy($id);
        if(!$res){
            throw new BaseException(['msg'=>'删除失败']);
        }else{
            return 1;
        }
    }
}
