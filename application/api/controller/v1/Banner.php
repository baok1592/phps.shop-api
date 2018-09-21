<?php
namespace app\api\controller\v1;

use app\api\model\BannerItem;
use app\api\validate\IDPostiveInt;
use app\api\model\Banner as BannerModel;
use app\lib\exception\BaseException;
use think\Request;
use app\api\model\Goods;
use app\api\model\Image;
use think\Validate;

//全站广告
class Banner extends Base
{
    //获取某个广告
    public function getbanneritem($id)
    {
        (new IDPostiveInt)->goCheck();
        $data=BannerModel::getBannerByID($id);
        return $data;
    }

    //获取所有广告位
    public function getbanners()
    {
        $data=BannerModel::all();
        return $data;
    }


    //添加广告
    public function create_ad()
    {
        $validate = Validate::make([
            'img_id'  => 'require|number',
            'banner_id' => 'require|number',
            'key_word' => 'require|chsAlphaNum'
        ]);
        $post = input('post.');
        if (!$validate->check($post)) {
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        $res = BannerItem::create($post);
        if(!$res){
            throw new BaseException(['msg'=>'添加失败']);
        }
        return 1;
    }
    
    //获取所有广告
    public function banner_all_item()
    {
        $res = BannerItem::with(['imgs','banner'])->select();
        if(!$res){
            throw new BaseException(['msg'=>'获取失败']);
        }
        return $res;
    }

    //删除广告
    public function del_ad($id)
    {
        (new IDPostiveInt)->goCheck();
        $res = BannerItem::destroy($id);
        if(!$res){
            throw new BaseException(['msg'=>'删除失败']);
        }else{
            return 1;
        }
    }

}
