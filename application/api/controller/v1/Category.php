<?php
namespace app\api\controller\v1;

use app\api\model\Category as CategoryModel;
use app\api\model\Image as ImageModel;
use app\api\validate\IDPostiveInt;
use app\api\model\Banner as BannerModel;
use app\lib\exception\BaseException;
use think\Validate;

//分类
class Category extends Base
{
    //获取X级分类信息
    public function getCateLevel($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=CategoryModel::getCategoryLevel($id);
        return $data;
    }
    //获取所有分类信息
    public function getCategory()
    {
        $data=CategoryModel::getCategoryAll();
        return $data;
    }
    //获取分类下所有子类与广告图
    public function getCateChildImg($id="")
    {
        (new IDPostiveInt)->goCheck();
        $data['category'] = CategoryModel::with('imgs')->where('pid',$id)->select();
        $banner = BannerModel::with(['items','items.imgs'])->find($id+1);
        $data['banner'] = $banner['items'];
        return  json($data);
    }

    //cms 获取所有分类并排好序，包括隐藏
    public function getCate_sort()
    {
        $data=CategoryModel::getCategoryAll(true);
        $data = subTree($data);

        return json($data,201);
    }
    //cms 删除分类
    public function del($id)
    {
        (new IDPostiveInt)->goCheck();
        $category_goods=(new Product)->getCatePros($id);
        if(count($category_goods)>0){
            throw new BaseException(['msg'=>'无法删除，该分类下有商品']);
        }
        $result = CategoryModel::where('category_id',$id)->delete();
        if($result){
            return 1;
        }else{
            return 0;
        }
    }

    //cms 新增分类
    public function add($form)
    {
        $validate = Validate::make([
            'category_name'=> 'require|min:2',
            'pid'=> 'require|number'
        ]);
        if (!$validate->check($form)) {
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        if($form['pid']==0){
            $form['level']=1;
        }else{
            $form['level']=2;
        }
        $form['sort']=0;
        $res = CategoryModel::create($form);
        if($res){
            return 1;
        }else{
            return 0;
        }
    }

    public function edit($form)
    {
        return json($form,201);
    }

    //cms更新分类
    public function up_cms_category($form)
    {
        $form = json_decode($form,true);
        $form_data['category_id']=$form['category_id'];
        $form_data['category_name']=$form['category_name'];
        $form_data['short_name']=$form['short_name'];
        $form_data['pid']=$form['pid'];
        $form_data['category_pic']=$form['category_pic'];
        if($form['pid']==0){
            $form_data['level']=1;
        }else{
            $form_data['level']=2;
        }
        $res = db('Category')->where(['category_id'=>$form['category_id']])->update($form_data);
        if($res){
            $data=db('Category')->where(['category_id'=>$form['category_id']])->find();
            $img=ImageModel::get(['id'=>$data['category_pic']]);
            $data['imgs'] = $img->url;
            $data['is_visible']= $data['is_visible'] == 1 ? true : false;
            return json($data,201);
        }
        return 0;
    }

}
