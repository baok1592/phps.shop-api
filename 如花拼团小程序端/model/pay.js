/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import {  HTTP }  from '../util/http.js'

class PayModel extends HTTP{ 
    //向API发送订单ID，返回支付数据
    ready(id) {
      return this.request({
        url: 'pay/pre_order',
        method: 'post',
        data: { id: id }
      });
    }

    //组装支付数据向微信API拉起支付弹窗
    pay(data) { 
      return new Promise((resolve, reject) => {
        var timeStamp = data.timeStamp;
        wx.requestPayment({
          'timeStamp': timeStamp.toString(),
          'nonceStr': data.nonceStr,
          'package': data.package,
          'signType': data.signType,
          'paySign': data.paySign,
          success: function (res) {  
            resolve(res.data)
          },
          fail: function (err) { 
            reject(err)
          }
        });
      })
    }
   
}

export { PayModel }