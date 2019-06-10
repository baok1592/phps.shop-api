<?php
namespace app\api\controller\v1;

use app\api\validate\IDPostiveInt;
use app\api\model\Favorites as FavModel;
use app\api\model\User as UserModel;
use app\api\service\TokenService;
use app\lib\exception\BaseException;
use app\lib\exception\SuccessMessage;
use app\api\model\Favorites as FavoritesModel;
use app\api\validate\FavValidate;
//用户收藏类
class Favorites extends Base
{
    protected $beforeActionList = [
        'checkScope'
    ];

    //查询某商品是否已收藏
    public function scFavGood($id='',$type='goods')
    {
        (new IDPostiveInt)->goCheck();
        $uid = TokenService::getCurrentUid();//接收token，获取uid
        $res=FavModel::getFavTypeByID($id,$uid,$type);
        return $res;
    }

    //获取该用户所有收藏
    public function getFav()
    {
        $uid = TokenService::getCurrentUid();//接收token，获取uid
        $data = FavoritesModel::getFavoriteByUid($uid);
        if(!$data){
            throw new BaseException(['msg'=>'获取用户收藏失败']);
        }
        return json($data);
    }

    //添加收藏
    public function addFavorite()
    {
        $validate=new FavValidate;
        $validate->goCheck();
        $data = $validate->getDataByRule(input('post.'));//过滤非验证器中的字段
        $data['uid'] = TokenService::getCurrentUid();//接收token，获取uid
        $FavModel=new FavModel;
        $res=$FavModel->where(['uid'=>$data['uid'],'fav_id'=>$data['fav_id']])->find();
        if($res){
            throw new BaseException(['msg'=>'已收藏过了']);
        }
        $res2=$FavModel->save($data);
        if(!$res2){
            throw new BaseException(['msg'=>'收藏失败']);
        }
        return json(new SuccessMessage(), 201);
    }
    
    //删除收藏
    public function delFavorite($id='')
    {
        (new IDPostiveInt)->goCheck();
        $uid=TokenService::getCurrentUid();
        return FavModel::favorite_del($id,$uid);
    }

}
