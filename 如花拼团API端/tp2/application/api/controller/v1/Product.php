<?php
namespace app\api\controller\v1;

use app\api\model\Goods;
use app\api\model\GoodsSku as GoodsSkuModel;
use app\api\validate\IDPostiveInt;
use  app\api\model\Item as ItemModel;
use app\api\model\Order as OrderModel;
use app\api\model\Rate as RateModel;
use app\api\validate\ProductValidate;
use app\lib\exception\BaseException;
use think\Db;
use think\Exception;

//商品类
class Product extends Base
{
    //获取某商品详情
    public function getProduct($id)
    {
        $data = Goods::getProductByID($id);
        return $data;
    }
    //获取最新商品
    public function getRecent($type='')
    {
        $data = Goods::getRecentAll($type);
        return $data;
    }
    //获取某商家所有商品
    public function getShopProduct($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = Goods::getShopID($id);
        return $data;
    }

    //获取某分类下所有商品
    public function getCatePros($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = Goods::getCatePros($id);
        return $data;
    }
    
    //获取某商品待参团的团单
    public function getItemHalf($id)
    {
        (new IDPostiveInt)->goCheck();
        //检测是否存在未拼团成功的团单，并改变它的状态
        ItemModel::checkItemExpire($id);
        return ItemModel::getItemByHalf($id); //获取某商品待参团的团单
    }

    //获取所有上架商品，包含分页
    public function getProducts($page=1, $size = 10,$key='')
    {
        // (new PagingParameter())->goCheck();
        if (isset($_GET['keywords']) and !empty($_GET['keywords'])) {
            $key = trim($_GET['keywords']);
            $num = Goods::where('state',1)->where('goods_name','like','%'.$key.'%')->count();
        }else{
            $num = Goods::where('state',1)->count();
        }
        $pagingOrders =  Goods::getProductByPage($page,$size,$key);

        if ($pagingOrders->isEmpty())
        {
            $data = [
                'current_page' => 1,
                'data' => [],
                'total' => $num
            ];
        }else {
            $data = $pagingOrders->toArray();
            $data['total'] = $num;
            $data['per_page'] = $data['per_page']*1;
        }
        return json($data,201);
    }

    //获取所有下架商品，包含分页
    public function getProductsDown($page=1, $size = 10)
    {
        // (new PagingParameter())->goCheck();
        $pagingOrders =  Goods::getProductDownByPage($page,$size);
        $num = Goods::where('state',0)->count();
        if ($pagingOrders->isEmpty())
        {
            $data = [
                'current_page' => 1,
                'data' => [],
                'total' => $num
            ];
        }else {
            $data = $pagingOrders->toArray();
            $data['total'] = $num;
            $data['per_page'] = $data['per_page']*1;
        }
        return json($data,201);
    }

    //cms 删除商品
    public function del($id)
    {
        (new IDPostiveInt)->goCheck();
        $good_one = Goods::get(['goods_id'=>$id]);
        $result = $good_one->delete(config('setting.soft_del'));   //这里是软删除
        if($result){
            return 1;
        }else{
            return 0;
        }
    }

    //cms 添加商品
    public function add()
    {
        $validate = new ProductValidate;
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));

       Db::startTrans();// 启动事务
       try {
            $res = Goods::create($post);

           //删除未填写价格的规格参数行
            foreach($post['sku'] as $k=>$v) {
                if (empty($v['price'])) {
                    unset($post['sku'][$k]);
                }
            }

            if ($res && count($post['sku']) > 0) {
                $list=$post['sku'];
                foreach($list as $k=>$v){
                    $list[$k]['goods_id']=$res->id;
                }
                $res2 = (new GoodsSkuModel)->saveAll($list);
                if(!$res2){
                    throw new BaseException(['msg'=>'添加规格错误']);
                }
            }
            Db::commit();
            return 1;
        } catch (Exception $e) {
            // 回滚事务
            Db::rollback();
            throw new BaseException(['msg'=>'商品添加失败']);
        }

    }

    //cms 修改商品
    public function EditProduct()
    {
        $validate = new ProductValidate;
        $validate->rule('goods_id', 'require|number');//新增一个验证规则，不让其过滤goods_id
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));//param数据对sku的操作会有问题
        Db::startTrans();// 启动事务
        try {
            $res = (new Goods)->save($post,['goods_id' => $post['goods_id']]);
            if(!$res){
                throw new BaseException(['msg'=>'xxx']);
            }
            //删除未填写价格的规格参数行
            //如果用request()->param 数据对sku的操作会有问题
            foreach($post['sku'] as $k=>$v) {
                if (empty($v['price'])) {
                    unset($post['sku'][$k]);
                }
            }
            if(count($post['sku'])==0){
                Db::commit();
                return 1;
            }
            $add_list=[];
            foreach($post['sku'] as $k=>$v){
                if(!empty($v['sku_id'])) {
                    (new GoodsSkuModel)->allowField(true)->save($v,['sku_id' => $v['sku_id']]);
                }else{
                    $add_list[$k]=$v;
                    $add_list[$k]['goods_id']=$post['goods_id'];
                }
            }
            $res2 = (new GoodsSkuModel)->saveAll($add_list);
            if(!$res2){
                throw new BaseException(['msg'=>'添加错误']);
            }
            Db::commit();
            return 1;
       }catch (Exception $e) {
            // 回滚事务
            Db::rollback();
            throw new BaseException(['msg'=>'商品修改失败']);
        }
    }

     //获取某个商品的所有评价
    public function getEvaluate($id)
    {
        (new IDPostiveInt)->goCheck();
        $pj=RateModel::with(['user'=>function($q){
                $q->field('id,nickname,headpic');
            }])->where('goods_id',$id)->order('id desc')->select();
        return json($pj);
    }
}
