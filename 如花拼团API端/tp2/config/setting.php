<?php

return [
    'app_id' => '',
    'app_secret' => '',
    'psw_code'=>'ru83hua98',
    'pay_back_url' => 'https://wx.phps.shop/v1/pay/notify',
    'access_token_url' => "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",
    'wx_login_url' => "https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code",
    'soft_del' => '', //取消未支付的团单或订单，true为真实删除
    'token_expire_in' => 7200,  //token过期时间，单位秒
];
