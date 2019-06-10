import { OrderModel } from '../../../model/order.js'
import { PayModel } from '../../../model/pay.js'

const orderModel = new OrderModel
const payModel = new PayModel()


Page({
 
  data: {
    current: 0,
  },
 
  onLoad: function (options) {
    wx.showLoading();
    if (options.ct >= 0) {
      this.setData({
        current: options.ct
      })
      this.tab_nav(options.ct)
    }
    this._load();
  },
  _load(){
    orderModel.get_MyOrderAll().then(res=>{
      this.setData({
        list: res
      });
      console.log(res[0]['ordergoods'])
      wx.hideLoading();
    }) 
    setTimeout(function () {
      wx.hideLoading()
    }, 2000);
  },
  tab_nav(key) {
    if (key == 1) {
      this.setData({
        pay: 0,
        drive: 0,
        receive:0
      });
    }
    if (key == 2) {
      this.setData({
        pay: 1,
        drive: 0,
        receive: 0
      });
    }
    if (key == 3) {
      this.setData({
        pay: 1,
        drive: 1,
        receive:0
      });
    }
    if (key == 4) {
      this.setData({
        pay: 1,
        drive: 1,
        receive: 1
      });
    }
  },
  change_tab({ detail }) {
    const key = detail.key
    this.setData({
      current: key
    })
    this.tab_nav(key)
  },  
  //支付
  onPay(event) { 
    const id = event.currentTarget.dataset.id
    payModel.ready(id).then(data => { 
      return payModel.pay(data)
    }).then(res => {
      this._jump_my(1)
    }).catch(err => {
      this._jump_my(0)
    })
  },

  _jump_my(res) {
    if (res == 1) {
      wx.showToast({
        title: "支付成功",
        icon: 'success',
        duration: 1500
      }); 
    } else {
      wx.showToast({
        title: "支付失败",
        icon: 'none',
        duration: 1500
      }); 
    }
  },
  jump(event){
    const id = event.currentTarget.dataset.id   
    wx.navigateTo({
      url: '../my_order_one/index?id='+id
    })
  }

})