<?php


namespace app\api\service;


use think\Exception;
use think\facade\Log;

class WxMessage
{
    private $sendUrl = "https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token=%s";
    private $touser;
    private $color = 'black'; //不让子类控制颜色

    protected $tplID;
    protected $page;
    protected $formID;
    protected $data;
    protected $emphasisKeyWord;

    function __construct()
    {
        $accessToken = new AccessToken();
        $token = $accessToken->get(); 
        $this->sendUrl = sprintf($this->sendUrl, $token['access_token']);//把百分号（%）符号替换成一个作为参数进行传递的变量： 
    }

    // 开发工具中拉起的微信支付prepay_id是无效的，需要在真机上拉起支付
    protected function sendMessage($openID)
    {
        Log::error('sendMessage');
        $data = [
            'touser' => $openID,
            'template_id' => $this->tplID,
            'page' => $this->page,
            'form_id' => $this->formID,
            'data' => $this->data,
            //'color' => $this->color,
            'emphasis_keyword' => $this->emphasisKeyWord
        ];

        Log::error($data);
        $result = curl_post($this->sendUrl, $data);
        $result = json_decode($result, true);
        if ($result['errcode'] == 0) {
            return true;
        } else {
            Log::error(json_encode($result));
            throw new Exception('模板消息发送失败,  ' . $result['errmsg']);
        }
    }
}