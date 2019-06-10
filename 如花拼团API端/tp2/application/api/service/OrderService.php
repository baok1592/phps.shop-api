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

class OrderService
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

    //创建普通商品订单
    public static function CreateCartOrder($post,$uid)
    {
        OrderService::CheckGoodsPrice($post['json']); //检查普通商品订单中所有商品的价格是否以数据库一致
        Db::startTrans();
        try {
            $order_data=OrderService::setOrderData($post,$uid);//组装订单数据
            $res_order=OrderModel::create($order_data);//创建订单
            if(!$res_order){
                throw new BaseException(['msg'=>'创建订单失败']);
            }
            $oid=$res_order->id;
            $goods=OrderService::setOrderGoods($oid,$post['json'],$uid);//组装订单商品数据
            (new OrderGoodsModel)->saveall($goods);
            Db::commit();
            return $oid;
        }catch (\Exception $e) {
            Db::rollback();// 回滚事务
            throw new BaseException(['msg'=>'创建订单失败-back']);
        }
    }



    //组装订单数据
    public static function setOrderData($post,$uid)
    {
        $data=[];
        $data['order_num'] = makeOrderNum();  //订单号
        $data['order_from'] = $post['order_from'];  //订单来源 0:小程序,1:wap
        $data['payment_type'] = $post['payment_type']; //支付方式
        $data['shipping_money'] = $post['shipping_money']; //订单运费
        $data['message'] = $post['msg']?$post['msg']:''; //留言
        $data['goods_money'] = $post['total'] ;    //商品总价'
        $data['order_money'] = $post['shipping_money'] + $data['goods_money'];  //订单总价

        $pinfo=GoodsModel::getProductByID($post['json'][0]['goods_id']);//获取商品及关联数据
        $data['goods_picture'] = self::getGoodsImg($pinfo,$post);  //商品图片ID
        $data['type'] = 0;
        //获取信息及用户地址
        $user_data=UserService::getUserInfo($uid);//直接用默认地址
        $arr=array_merge($data,$user_data);
        return $arr;
    }


    //组装普通商品订单的 商品数据
    public static function setOrderGoods($order_id,$post,$uid)
    {
        $data=[];
        foreach($post as $k=>$v){
            $data[$k]=$v;
            $data[$k]['user_id']=$uid;
            $data[$k]['order_id']=$order_id;
            $data[$k]['total_price']=$v['price'] * $v['num'];
            $pinfo=GoodsModel::getProductByID($v['goods_id']);//获取商品及关联数据
            $data[$k]['pic_id'] = self::getGoodsImg($pinfo,$post);  //商品图片ID
        }
        return $data;
    }


    //验证商品价格
    public static function CheckGoodsPrice($post)
    {
        foreach($post as $k=>$v) {
            $pinfo=GoodsModel::getProductByID($v['goods_id']);
            if (empty($v['sku_id']) || empty($v['sku_name'])) {
                //无规格的订单商品
                if($pinfo['price']!=$v['price']){
                    throw new BaseException(['msg'=>'商品价格有误']);
                }
            } else {
                foreach ($pinfo['sku'] as $pk=>$pv){
                    if($pv['sku_id'] == $v['sku_id']){
                        if($pv['price'] != $v['price']) {
                            throw new BaseException(['msg' => '商品价格有误']);
                        }
                    }
                }
            }
        }
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




}