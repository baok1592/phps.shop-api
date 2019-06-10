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

use app\api\model\Item as ItemModel;
use app\lib\enum\OrderEnum;
use app\lib\exception\BaseException;
use think\Db;
use think\Exception;
use think\facade\Log;
use WxPay\WxPayNotify;
use app\api\model\Order as OrderModel;
use app\api\model\Goods as GoodsModel;
use app\api\model\GoodsSku as GoodsSkuModel;

class WxNotifyService extends  WxPayNotify
{
    //异步接收微信回调，更新订单状态
    public function NotifyProcess($data, &$msg)
    {
        if ($data['result_code'] == 'SUCCESS')
        {
            $orderNo = $data['out_trade_no'];           

            Db::startTrans();
            try
            {
                //Lock方法是用于数据库的锁机制;
                $order = OrderModel::where('order_num', $orderNo)->lock(true)->find();

                if ($order->pay_status == 0)
                {
                    //$res = OrderService::checkOrderStock($order->order_id);//检查库存
                   // if(!$res){
                       // $this->updateOrderStatus($order->order_id, false);  //更新订单状态为已支付但库存不足
                   // }else{
                        $this->updateOrderStatus($order->order_id, true);  //更新订单状态为已支付
                        if($order->item_id>0) {
                            $this->upItemStatus($order->order_id, $order->item_id);//判断并更新团单
                        }
                        //$this->reduceStock($order); //扣除库存
                    //}
                    Db::commit();
                    //$message = new DeliveryMessage();
                    //$message->sendDeliveryMessage($order, '');
                }
                
            }catch (Exception $ex){
                Db::rollback();
                Log::error('更新订单Notify:'.$ex);
                return false;
            }  
            return true;
        }else{
            return true;
        }
    }

    //扣除库存
    private function reduceStock($order)
    {
        if($order['sku_id'] == 0 || empty($order['sku_name'])){
            GoodsModel::where('goods_id',$order['goods_id'])->setDec('stock', $order['num']);
        }else{
            GoodsSkuModel::where('goods_id',$order['goods_id'])->where('sku_id',$order['sku_id'])->setDec('stock', $order['num']);
        }
    }

    //订单更新状态为：已支付 或 已支付但库存不足
    private function updateOrderStatus($orderID, $success)
    {
        $status = $success ? OrderEnum::PAYID : OrderEnum::PAYID_BUT_OUT_OF;
        OrderModel::where('order_id', $orderID) -> update(['pay_status' => $status]);
    }

    //判断并更新团单
    private function upItemStatus($orderID,$itemID){
        $res = PtOrderService::ItemLikeOrder($orderID); //判断该订单用户是否为团单发起者
        if($res){
            $status = ItemModel::where('id', $itemID)->value('item_status');
            //0为过期，1为待支付
            if($status == 0){
                throw new Exception();
            }
            if($status == 1){
                ItemModel::where('id', $itemID) -> update(['item_status' => 2]);
            }
        }
    }
}