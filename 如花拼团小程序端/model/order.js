/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import { HTTP }  from '../util/http.js'

class OrderModel extends HTTP{
    
    get_MyOrderAll(){
      return this.request({
        url: 'order/all',
        method: 'post',      
      });
    } 

    get_MyOrder(id){
      return this.request({
        url: 'order/get_order_one',
        method: 'post',
        data: {id:id}
      });
    }
    //创团，独立购买拼团
    createOrder(param){
      return this.request({
        url: 'order/create',
        method: 'post',
        data: param
      })
    }
    //购物车下单
    CreatessOrder(param){
      return this.request({
        url: 'order/create_cart',
        method: 'post',
        data: param
      })
    }
    //提交评价
    set_pj(param) {
      return this.request({
        url: 'order/set_pj',
        method: 'post',
        data: param
      })
    }
    //退款申请
    tuikan(param) {
      return this.request({
        url: 'order/tuikuan',
        method: 'post',
        data: param
      })
    }
    //确认收货
    receive(id) {
      return this.request({
        url: 'order/receive',
        method: 'post',
        data: {
          id
        }
      })
    }
}

export { OrderModel }