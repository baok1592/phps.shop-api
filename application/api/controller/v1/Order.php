<?php
namespace app\api\controller\v1;

use app\api\model\Goods as GoodsModel;
use app\api\model\Item as ItemModel;
use app\api\service\OrderService;
use app\api\service\TokenService;
use app\api\validate\IDPostiveInt;
use app\api\validate\NameValidate;
use app\api\validate\OrderValidate;
use app\api\model\Order as OrderModel;
use app\api\validate\PushOrderValidate;
use app\lib\exception\BaseException;
use app\lib\exception\SuccessMessage;

//团单+订单类
class Order extends Base
{
    //创建拼团或独立购买
    public function CreateOrder()
    {
        $validate = new OrderValidate;
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));
        $uid = TokenService::getCurrentUid();
        $res=OrderService::CreateItemAndOrder($post,$uid);//创建团单和订单
        return $res;
    }

    //参加拼团
    public function PushOrder()
    {
        $validate = new PushOrderValidate;
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));
        $uid = TokenService::getCurrentUid();
        OrderService::check_item($post,$uid);   //检测团单,人数是否已满，是否已经在该团单中了

        $pinfo=GoodsModel::getProductByID($post['goods_id']);//获取商品及关联数据
        $order_data=OrderService::setOrderData($pinfo,$post,$uid);//组装订单数据
        $order_data['item_id'] = $post['item_id'];
        $res_order=OrderModel::create($order_data);//创建订单
        if(!$res_order){
            throw new BaseException(['创建订单失败']);
        }
        //检测是否更新团单状态
        return json((new SuccessMessage),201);
    }
    
    //获取用户所有订单信息
    public function getUserOrderAll()
    {
        $uid = TokenService::getCurrentUid();
        $data=OrderModel::with('item,imgs')->where(['user_id'=>$uid])->order('order_id desc')->select();
        return $data;
    }

    //获取用户指定的一条订单信息
    public function getUserOrderOne($id="")
    {
        (new IDPostiveInt)->goCheck();
        $uid = TokenService::getCurrentUid();
        $data = OrderModel::with('item,imgs')->where(['user_id'=>$uid,'order_id'=>$id])->find(); //常规查询自动不包含软删除的数据
        if(!$data){
            throw new BaseException(['msg'=>'获取订单数据失败']);
        }
        return $data;
    }

    //删除一条自己未支付的订单
    public function DeleteOrder($id="")
    {
        (new IDPostiveInt)->goCheck();
        $uid = TokenService::getCurrentUid();
        //$data = OrderModel::where(['user_id'=>$uid,'order_id'=>$id,'pay_status'=>0])->delete();//这样的删除不支持软删除
        $order_one = OrderModel::get(['order_id'=>$id]);
        if ($order_one['user_id'] == $uid && $order_one['pay_status'] == 0) {
            $order_one->delete(config('setting.soft_del'));   //这里是软删除
            //是否为创团订单，若是则删除团单
            if($order_one['create_item']==1) {
                $this->CheckItemDel($uid, $order_one['item_id']);
            }
        }else{
            throw new BaseException(['msg'=>'订单删除失败']);
        }
        return json((new SuccessMessage),201);
    }
    //cms删除订单
    public function del($id)
    {
        (new IDPostiveInt)->goCheck();
        $order_one = OrderModel::get(['order_id'=>$id]);
        $result = $order_one->delete(config('setting.soft_del'));   //这里是软删除
        if($result){
            return 1;
        }else{
            return 0;
        }
    }
    //检测item_id和uid后删除团单
    public function CheckItemDel($uid,$item_id)
    {
        $item_one = ItemModel::get($item_id);
        //团单过期或未支付时允许删除
        if ($item_one['operator_id'] == $uid && $item_one['item_status'] < 2) {
            $item_one->delete(config('setting.soft_del'));   //这里是软删除
        }
    }

    //获取所有团单详细
    public function GetOrderItemAll($page=1,$size=10)
    {
        $pagingOrders =  ItemModel::getItemByPage($page,$size);
        $num = ItemModel::count();
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
        }
        return json($data,201);
    }
    //获取所有订单简要
    public function GetOrderAll($page=1, $size = 10)
    {
        $key = $this->request->param('keywords')?:'';
        if (isset($key) and !empty($key)) {
            $key = trim($key);
            $num = OrderModel::where('order_num','like','%'.$key.'%')->count();
        }else{
            $num = OrderModel::count();
        }

        $pagingOrders =  OrderModel::getOrderByPage($page,$size,$key);
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
        }
        return json($data,201);
    }
    //获取指定订单详细
    public function GetOrderOne($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = OrderModel::get(['order_id'=>$id]);
        return $data;
    }

    //搜索订单
    public function SearchOrder($name)
    {
        (new NameValidate)->goCheck();
        $uid = TokenService::getCurrentUid();
        $data = OrderModel::where('user_id',$uid)->where('goods_name','like','%'.$name.'%')->select();
        return $data;
    }
}

