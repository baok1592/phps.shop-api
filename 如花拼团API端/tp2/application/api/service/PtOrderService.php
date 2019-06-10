<?php
/**
 * 如花拼团开源系统 -- 永久免费
 * =========================================================
 * 官方网址：http://www.phps.shop
 * 作者：光爵【API + 后台】 、 小草【小程序 + WAP】
 * QQ 交流群：728615087
 * Version：1.0.0
 */

namespace app\api\service;

use app\api\model\Goods as GoodsModel;
use app\api\model\Item;
use app\api\model\Order as OrderModel;
use app\api\model\OrderGoods as OrderGoodsModel;
use app\api\model\Item as ItemModel;
use app\lib\exception\BaseException;
use app\lib\exception\SendMsg;
use app\lib\exception\SuccessMessage;
use think\Db;

class PtOrderService
{

    //检测是否已在该团单中、人数是否已满
    public static function check_item($post,$uid)
    {
        //检测是否已在该团单中
        $arr=OrderModel::getOneItemUsers($post);  //获取指定团单下所有订单的购买者id
        $res=in_array($uid,$arr);
        if($res){
            throw new BaseException(['msg'=>'您已经在该团单中了']);
        }

        //检测人数是否已满
        $people=ItemModel::getItemPeople($post['item_id']);//该团单需拼团人数
        $start_people=count($arr);//该团单已拼团人数
        if(($people - $start_people)<1){
            throw new BaseException(['msg'=>'该团单人数已满']);
        }
    }

    //创建团单和拼团订单
    public static function CreateItemAndOrder($post,$uid)
    {
        $pinfo=GoodsModel::getProductByID($post['goods_id']);//获取商品及关联数据
        Db::startTrans();
        try {
            $order_data=PtOrderService::setOrderData($pinfo,$post,$uid);//组装拼团订单数据

            if($post['type']=='pintuan') {
                $count=ItemModel::where(['item_status'=>1,'operator_id'=>$uid])->count();
                if($count>=5){
                    throw new BaseException(['msg'=>'您已提交多次，请支付或删除订单后继续下单']);
                } 
                $item_data = PtOrderService::setItemData($pinfo,$post,$uid); //组装团单数据
                $res=ItemModel::create($item_data);  //创建团单
                $item_id=$res->id;
                if($item_id<1){
                    throw new BaseException(['msg'=>'创建拼团失败']);
                }
                $order_data['item_id'] = $item_id;
                $order_data['is_first'] = 1;
            }

            $res_order=OrderModel::create($order_data);//创建订单
            if(!$res_order){
                throw new BaseException(['msg'=>'创建订单失败']);
            }
            $oid=$res_order->id;
            $goods=PtOrderService::setOrderPtGoods($oid,$uid,$pinfo,$post);//组装拼团订单商品数据
            $res=OrderGoodsModel::create($goods);
            if(!$res){
                throw new BaseException(['msg'=>'创建订单失败2']);
            }
            Db::commit();
        }catch (Exception $e) {
            Db::rollback();// 回滚事务
            throw new BaseException(['msg'=>$e->getMessage()]);
        }
        if(!$res_order){
            throw new BaseException(['msg'=>'创建订单失败3']);
        }
       return $res_order->id;
    }

    //组装拼团订单数据
    public static function setOrderData($pinfo,$post,$uid)
    {
        $res=self::getPrice($pinfo,$post); //验证商品价格
        if(!$res){
            throw new BaseException(['msg'=>'商品价格有误']);
        }
        $data=[];
        $data['order_num'] = makeOrderNum();  //订单号
        $data['order_from'] = $post['order_from'];  //订单来源 0:小程序,1:wap
        $data['payment_type'] = $post['payment_type']; //支付方式
        $data['shipping_money'] = $post['shipping_money']; //订单运费
        $data['message'] = $post['msg']?$post['msg']:''; //留言
        $data['goods_money'] = $post['total'] ;    //商品总价'
        $data['order_money'] = $post['shipping_money'] + $data['goods_money'];  //订单总价
        $data['goods_picture'] = self::getGoodsImg($pinfo,$post);  //商品图片ID
        $data['type'] = 1;
            //获取信息及用户地址
        $user_data=UserService::getUserInfo($uid);//直接用默认地址
        $arr=array_merge($data,$user_data);
        return $arr;
    }

    //组装拼团商品订单的 商品数据
    public static function setOrderPtGoods($order_id,$uid,$pinfo,$post)
    {
        $data=$post;
        $data['goods_name'] = $pinfo['goods_name']; //商品名称
        $data['user_id']=$uid;
        $data['order_id']=$order_id;
        $data['num'] = $post['number'];     //下单商品数量
        $data['message'] = $post['msg']?$post['msg']:''; //留言
        $data['total_price'] = $post['price'] * $post['number'];   //下单商品单价
        $data['pic_id'] = self::getGoodsImg($pinfo,$post);  //商品图片ID
        return $data;
    }

    //组装团单数据
    public static function setItemData($pinfo,$post,$uid)
    {
        $item_data=[];
        $res=self::getPrice($pinfo,$post); //验证商品价格
        if(!$res){
            throw new BaseException(['msg'=>'商品价格有误']);
        }
        $item_data['price'] = $post['price'];   //下单商品单价
        $item_data['item_people']=$pinfo['people']; //拼团限制人数
        $item_data['shop_id']=$pinfo['shop_id'];
        $item_data['shop_name']=$pinfo['shop_name'];
        $item_data['goods_id']=$pinfo['goods_id'];
        $item_data['goods_name']=$pinfo['goods_name'];
        $item_data['operator_id']=$uid;
        return $item_data;
    }



    //验证商品价格
    public static function getPrice($pinfo,$post)
    {
        //无规格的订单商品
        if(empty($post['sku_id']) || empty($post['sku_name'])){
            if($post['type']=='only'){
                if($pinfo['only_price'] != $post['price']){
                    return false;
                }
            }else{
                if($pinfo['price'] != $post['price']){
                    return false;
                }
            }
        }else {
            //有规格的订单商品
            foreach ($pinfo['sku'] as $k => $v) {
                if ($v['sku_id'] == $post['sku_id']) {
                    if($post['type']=='only'){
                        if ($v['only_price'] != $post['price']) {
                            return false;
                        }
                    }else{
                        if ($v['price'] != $post['price']) {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }

    //判断返回商品图片或规格图片
    public static function getGoodsImg($pinfo,$post)
    {
        //无规格的订单商品
        if(empty($post['sku_id']) || empty($post['sku_name'])){
            return $pinfo['img_id'];
        }else {
            //有规格的订单商品
            foreach ($pinfo['sku'] as $k => $v) {
                if ($v['sku_id'] == $post['sku_id']) {
                    return $v['picture'];
                }
            }
        }
        return true;
    }



    //检测团单下所有订单是否都已支付，并改变状态
    public static function checkOrderAllPayStatus($item_id)
    {
        $pay_arr = OrderModel::where(['item_id'=>$item_id])->column('pay_status');//获取该团单所有的订单的支付状态
        $people=ItemModel::getItemPeople($item_id);//该团单需拼团的人数
        if(!in_array(0,$pay_arr) && count($pay_arr) == $people){
            //都已支付，并且订单数等于拼团要求人数，更新团单状态
            $res = ItemModel::where("id",$item_id)->update(['item_status'=>2]);
            if(!$res){
                throw new BaseException(['团单更新失败']);
            }
            return true;
        }
        return 0;
    }

    //检测订单商品的库存
    public static function checkOrderStock($orderID)
    {
        $Product_order = OrderModel::where('order_id',$orderID)->field('goods_id,num,sku_id,sku_name,order_money')->find();
        $Product_good = GoodsModel::getProductByID($Product_order['goods_id']);
        if($Product_order['sku_id'] == 0 || empty($Product_order['sku_name'])){
            if($Product_good['stock'] < $Product_order['num']){
                return false;
            }else{
                return true;
            }
        }else{
            foreach ($Product_good['sku'] as $k=>$v){
                if($v['sku_id'] == $Product_order['sku_id']){
                    if($v['stock'] < $Product_order['num']){
                        return false;
                    }else{
                        return true;
                    }
                }
            }
        }
    }

    //判断该订单用户是否为团单发起者
    public static function ItemLikeOrder($orderID)
    {
        $order = OrderModel::get(['order_id'=>$orderID]);
        $operator_id = ItemModel::where('id',$order['item_id'])->value('operator_id');
        if($operator_id == $order['user_id']){
            return true;
        }else{
            return false;
        }
    }


}