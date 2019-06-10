<?php

namespace app\api\service;


use app\api\model\Order as OrderModel;
use app\api\model\Tui as TuiModel;
use app\api\model\Tui;
use app\lib\exception\BaseException;
use think\Exception;
use WxPay\WxPayApi;
use WxPay\WxPayData;
use WxPay\WxPayRefund;


class TuiService
{
    private $orderID;

    function __construct($orderID)
    {
        if (!$orderID)
        {
            throw new Exception('订单号不允许为NULL');
        }
        $this->orderID = $orderID;
    }

    /* 申请退款，WxPayRefund中out_trade_no、transaction_id至少填一个且
    * out_refund_no、total_fee、refund_fee、op_user_id为必填参数
    */
    public function pay()
    {
        $aid = TokenService::getCurrentAid();
        $order=OrderModel::get(['order_id'=>$this->orderID]);
        $order_sn=$order['order_num'];
        $refund_no='tui'.rand(10000, 99999); //退款单号
        $total_fee=$order['order_money']*100;
        $refund_fee=$order['order_money']*100;
        $merchid=$aid;

        new WxPayData();
        $input = new WxPayRefund();
        $input->SetOut_trade_no($order_sn);			//自己的订单号
        $input->SetOut_refund_no($refund_no);			//退款单号
        $input->SetTotal_fee($total_fee);			//订单标价金额，单位为分
        $input->SetRefund_fee($refund_fee);			//退款总金额，订单总金额，单位为分，只能为整数
        $input->SetOp_user_id($merchid);    //操作员ID

        $res = WxPayApi::refund($input);	//退款操作
        if(isset($res['err_code'])){
            throw new BaseException([ 'msg'=>$res['err_code_des'] ]);
        }
        if(isset($res['refund_id'])){
            $res=TuiModel::where(['status'=>0,'order_num'=>$order['order_num']])->update(['status'=>1,'wx_id'=>$res['refund_id']]);
            if($res){
                return 1;
            }
            throw new BaseException([ 'msg'=>'退款异常' ]);
        }else{
            throw new BaseException([ 'msg'=>'退款异常' ]);
        }
    }



}