<?php
namespace app\api\controller\v1;

use app\api\model\Goods;
use app\api\model\Goods as GoodsModel;
use app\api\model\OrderGoods;
use app\api\model\User as UserModel;
use app\api\model\Item as ItemModel;
use app\api\model\Order as OrderModel;
use app\api\model\Tui as TuiModel;
use app\api\model\OrderLog;
use app\api\service\OrderService;
use app\api\service\PtOrderService;
use app\api\service\TokenService;
use app\api\service\TuiService;
use app\api\validate\IDPostiveInt;
use app\api\validate\NameValidate;
use app\api\validate\OrderValidate;
use app\api\validate\ShoppingValidate;
use app\api\validate\PushOrderValidate;
use app\lib\exception\BaseException;
use app\lib\exception\SuccessMessage;
use think\Db;
use think\Exception;
use think\facade\Request;
use think\Validate;
use app\api\model\Rate as RateModel;

//团单+订单类
class Order extends Base
{
    //创建拼团
    public function CreateOrder()
    {
        $validate = new OrderValidate;
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));
        $uid = TokenService::getCurrentUid();
        $res = PtOrderService::CreateItemAndOrder($post, $uid);//创建团单和拼团订单
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

    //普通商品下单
    public function CreateCartOrder()
    {
        $validate = new ShoppingValidate;
        $validate->goCheck();
        $post = $validate->getDataByRule(input('post.'));
        $uid = TokenService::getCurrentUid();
        $res = OrderService::CreateCartOrder($post, $uid);//创建订单
        return $res;
    }

    //获取我的所有订单信息
    public function getUserOrderAll()
    {
        $uid = TokenService::getCurrentUid();
        $data= OrderModel::with('ordergoods,item,imgs')->where(['user_id'=>$uid])->order('order_id desc')->select();
        return $data;
    }

    //获取用户指定的一条订单信息
    public function getUserOrderOne($id="")
    {
        (new IDPostiveInt)->goCheck();
        $uid = TokenService::getCurrentUid();
        $data = OrderModel::with('rate,ordergoods,item,ordergoods.imgs')->where(['user_id'=>$uid,'order_id'=>$id])->find(); //常规查询自动不包含软删除的数据
        $tui_data=TuiModel::where('order_id',$id)->select();
        $data['rate']=RateModel::where('order_id',$id)->find();
        if($tui_data){
            $data['tui']=$tui_data;
        }
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
    //获取指定订单详细--CMS
    public function GetOrderOne($id)
    {
        (new IDPostiveInt)->goCheck();
        $data = OrderModel::with('ordergoods,imgs')->get(['order_id'=>$id]);
        $data['log'] = OrderLog::where(['order_id'=>$id])->order('create_time desc')->select();
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
    //更新订单配送信息
    public function up_courire()
    {
        $param=Request::param();
        $validate = new Validate();
        $validate->rule('courier', 'require');
        $validate->rule('courier_num', 'require|number|min:5');
        $validate->rule('order_id', 'require|number');
        if(!$validate->check($param)){
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        $res = OrderModel::up_courire_model($param);
        if($res){
            return json(new SuccessMessage(['msg'=>'录入成功']));
        }else{
            return 0;
        }
    }
    //添加订单备注信息
    public function up_remark()
    {
        $param=Request::param();
        $validate = new Validate();
        $validate->rule('remark', 'require');
        $validate->rule('order_id', 'require|number');
        if(!$validate->check($param)) {
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        $res = OrderModel::up_remark_model($param);
        if($res){
            return json(new SuccessMessage(['msg'=>'录入成功']));
        }else{
            return 0;
        }
    }
    //修改订单价格
    public function edit_price()
    {
        $param=Request::param();
        $validate = new Validate();
        $validate->rule('price', 'require');
        $validate->rule('order_id', 'require|number');
        if(!$validate->check($param)) {
            throw new BaseException(['msg'=>$validate->getError()]);
        }
        $res = OrderModel::edit_price_model($param);
        if($res){
            return json(new SuccessMessage(['msg'=>'修改成功']));
        }else{
            return 0;
        }
    }
     //提交评价
    public function set_pj()
    {
        $post=input('post.');
        $where['user_id'] = TokenService::getCurrentUid();
        $where['order_id'] = $post['id'];
        $order=OrderModel::where($where)->find();
        if(!$order){
            throw new BaseException(['msg'=>'评价出现错误']);
        }
        $order_id=$order['order_id'];
        $data['user_id']= $where['user_id'];
        $data['rate']=$post['rate'];
        $data['content']=$post['content'];
        $data['order_id']=$order_id;
        $ordergoods=new OrderGoods;
        $rate=new RateModel;
        Db::startTrans();
        try {
            $order->save(['evaluate_status'=>1]);
            $good_ids=$ordergoods->where('order_id',$order_id)->column('goods_id');
            foreach ($good_ids as $k=>$v){
                $data['goods_id']=$v;
                $data['create_time']=time();
                $rate->insert($data);
            }
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            throw new BaseException(['msg'=>'更新失败']);
        }
        return 1;
    }

    public function tuikuan_approve()
    {
        $post=input('post.');

        $ck=TuiModel::where(['order_id'=>$post['id'],'status'=>['>',0]])->find();
        if($ck){
            throw new BaseException(['msg'=>'已存在正在处理的退款申请']);
        }
        $where['user_id'] = TokenService::getCurrentUid();
        $where['order_id']=$post['id'];
        $where['pay_status']=1;
        $where['drive_status']=0;
        $where['tui_status']=0;
        $order=OrderModel::where($where)->find();
        if(!$order){
            throw new BaseException(['msg'=>'订单状态有误']);
        }
        $data['order_id']=$order['order_id'];
        $data['nickname']=UserModel::where(['id'=>$order['user_id']])->value('nickname');
        $data['order_num']=$order['order_num'];
        $data['money']=$order['order_money'];
        $data['because']=$post['radio']?:"";
        $data['message']=$post['content']?:"";
        Db::startTrans();
        try {
            $res = $order->save(['tui_status' => 1]);
            if (!$res) {
                throw new BaseException(['msg' => '订单状态有误!']);
            }
            $res = TuiModel::create($data);
            Db::commit();
        }catch (\Exception $e){
            Db::rollback();
            throw new BaseException(['msg'=>'更新失败']);
        }
        return $res?1:0;
    }

    //cms 获取所有退款信息
    public function getTuiAll()
    {
        $res=TuiModel::select();
        return json($res);
    }
    //微信退款 
    public function TuiMoney($id)
    {
        $order_num=OrderModel::where(['order_id'=>$id])->value('order_num');
        $tui=TuiModel::where(['status'=>0 , 'order_num'=>$order_num])->find();
        if(!$tui){
            throw new BaseException(['msg'=>'退款订单异常']);
        }
        $tui = new TuiService($id);
        return $tui->pay();
    }
     //退款申请驳回
    public function TuiBoHui($id,$msg)
    {
        //这里的id是tui的id
        $tui=TuiModel::get($id);
        $order_id=$tui->order_id;
        $aid=TokenService::getCurrentAid();
        $data['aid']=$aid;
        $data['remark']=$msg;
        $data['status'] = -1;
        Db::startTrans();
        try {
            $tui->save($data);
            $res = OrderModel::where(['order_id' => $order_id, 'tui_status' => 1])->update(['tui_status' => 0]);
            Db::commit();
            return $res ? 1 : 0;
        }catch (Exception $e){
            Db::rollback();
            throw new BaseException(['msg'=>$e->getMessage()]);
        }
    }
     //确认收货
    public function receive($id)
    {
        (new IDPostiveInt)->goCheck();
        $where['drive_status']=1;
        $where['receive_status']=0;
        $where['order_id']=$id;
        $order=OrderModel::where($where)->find();
        if(!$order){
            throw new BaseException(['msg'=>'订单状态有误']);
        }
        $res=$order->save(['receive_status'=>1]);
        return $res?1:0;
    }
}

