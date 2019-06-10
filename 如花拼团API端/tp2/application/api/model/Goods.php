<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace app\api\model;


use app\lib\exception\BaseException;
use think\model\concern\SoftDelete;

class Goods extends BaseModel
{
  /* protected $visible = ['goods_id','goods_name','market_price','price','shop_name','item_people','stock','img_id','content','description',
        'picture','imgs','sku','sales','category_id','shop_id'];
  */
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    protected $hidden = ['is_stock_visible','is_pre_sale','is_bill'];

    //关联图片
    public function imgs()
    {
        return $this->belongsTo('Image','img_id','id');
    }
  

    //关联规格
    public function sku()
    {
        return $this->hasMany('GoodsSku','goods_id','goods_id');
    } 

     //ID获取某商品及关联详情
    public static function getProductByID($id)
    {
        $data = self::with(['imgs','sku','sku.imgs'])->where('goods_id',$id)->find();
        $data['rate_num']=Rate::where('goods_id',$id)->count();
        $data['rates']=Rate::with(['user'=>function($q){
            $q->field('id,nickname,headpic');
        }])->where('goods_id',$id)->order('id desc')->limit(2)->select();
        $img = Image::where('id','in',$data['img_id_array'])->select();
        $data['img_id_array']=$img;
        if(!$data){
            throw new BaseException(['msg'=>'商品不存在或数据错误']);
        }
        return $data;
    }
    //name获取某商品详情
    public static function getProductByName($name)
    {
        $data = self::with('imgs')->where('goods_name','like','%'.$name.'%')
              ->order('real_sales desc')->select();
        if(!$data){
            throw new BaseException(['msg'=>'商品不存在或数据错误']);
        }
        return $data;
    }
    //获取某商家所有商品
    public static function getShopID($id)
    {
        $data = self::with('imgs')->where('shop_id',$id)->select();
        if(!$data || count($data)<1){
            throw new BaseException(['msg'=>'获取店铺商品失败或无数据']);
        }
        return $data;
    }
    //获取所有、最新、最热、推荐商品
    public static function getRecentAll($type)
    {
        if($type=='new'){
            $data=self::with('imgs')->where('is_new',1)->where('state',1)->select();
        }else if($type=='hot'){
            $data=self::with('imgs')->where('is_hot',1)->where('state',1)->select();
        }else if($type=='recommend'){
            $data=self::with('imgs')->where('is_recommend',1)->where('state',1)->select();
        }else{
            $data=self::with('imgs')->where('state',1)->select();
        }
        if(!$data || count($data)<1){
            throw new BaseException(['msg'=>'获取最新商品失败或无数据']);
        }
        return $data;
    }
    //获取所有上架商品，包含分页
    public static function getProductByPage($page=1, $size=10,$key=''){
        if(!empty($key)){
            $pagingData = self::with('imgs')->where('state',1)->where('goods_name','like','%'.$key.'%')
                ->order('create_time desc')->paginate($size, true, ['page' => $page]);
        }else{
            $pagingData = self::with('imgs')->where('state',1)->order('create_time desc')
                ->paginate($size, true, ['page' => $page]);
        }
        return $pagingData ;
    }

    //获取所有下架商品，包含分页
    public static function getProductDownByPage($page=1, $size=10){
        $pagingData = self::with('imgs')->where('state',0)->order('create_time desc')
            ->paginate($size, true, ['page' => $page]);
        return $pagingData ;
    }

    //获取某分类下面的所有商品
    public static function getCatePros($cid)
    {
        $cwhere['category_id']=$cid;
        $cwhere['pid']=$cid;
        $cid_arr=Category::where('category_id',$cid)->where('level',2)->whereor('pid',$cid)->field('category_id')->select();
        $cid_arr=$cid_arr->toArray();//注意select获得是数据集，数据集走array_column函数会报错，需要转成数组
        $cids=array_column($cid_arr,'category_id');
        $str=implode($cids,',');
        $data = self::with('imgs')->where('category_id','in',$str)->select();
        if(!$data){
            throw new BaseException(['msg'=>'获取分类商品失败或无数据']);
        }
        return $data;
    }

    public function setImgsAttr($v)
    {
        return $v['url'];
    }
    public function getIsHotAttr($v)
    {
        return $v==1 ? true : false;
    }
    public function getIsRecommendAttr($v)
    {
        return $v==1 ? true : false;
    }
    public function getIsNewAttr($v)
    {
        return $v==1 ? true : false;
    }
    public function getStateAttr($v)
    {
        return $v==1 ? true : false;
    }
}