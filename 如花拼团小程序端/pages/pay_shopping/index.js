import { MyModel }   from '../../model/my.js'
import { OrderModel } from '../../model/order.js'
import { PayModel } from '../../model/pay.js'

const myModel = new MyModel()
const orderModel = new OrderModel()
const payModel = new PayModel()

Page({
  data: {
    total:0,
    xianzhi:99,
    address:false,
    num:1,
    buy_type:'' 
  },
  onLoad: function (options) {  
    this._load();
  },
  onShow: function (options) {
    this._load();
  },
  _load() {
    wx.showLoading();
    this.msg = ''
    this._count_price()

    const data=this._setListData();   
    this.setData({
      list:data
    })
    myModel.get_address_default().then(res => {
      this.setData({
        address: res
      })
      wx.hideLoading()
    }) 
  },
  
  onMsg(trigger){
    this.msg = trigger.detail
  },

  //组装下单数据
  _setPayData() {
    const json=this.data.list
    const total=this.data.total_price
    return {
      payment_type: 'wx',
      order_from: 0,       
      shipping_money: 0,     
      msg: this.msg,
      "type": 'shopping',
      json,
      total
    } 
  },
  //创建订单并支付
  onPay(){
    const obj = this._setPayData()
    orderModel.CreatessOrder(obj).then(res=>{ 
      this._delCart() //从购物车 删除 购买的商品
      return payModel.ready(res)
    }).then(data => {
      return payModel.pay(data)
    }).then(res => {
      this._jump_my(1)
    }).catch(err => {
      if (err.error_code != 10000) {
        this._jump_my(0)
      }
    })
  },
  //组装列表数据
  _setListData() {
    let obj = {}
    const cart_cache = wx.getStorageSync('cart')
    const cache = wx.getStorageSync('total')
    const cache_arr = Object.keys(cache)
    for (let i = 0; i < cache_arr.length; i++) {
      let key = cache_arr[i]
      if (cache[key]['scheck']) {
        obj[i] = {
          goods_id: cart_cache[key]['goods_id'],
          goods_name: cart_cache[key]['goods_name'],
          sku_id: cart_cache[key]['sku_id'],
          sku_name: cart_cache[key]['sku_name'],
          img: cart_cache[key]['img'],
          price: cache[key]['price'],
          num: cache[key]['num'],
        }
      }
    }
    return obj
  },
  //计算勾选商品的总价
  _count_price() {
    const total_cache = wx.getStorageSync('total')
    const cart_arr = Object.keys(total_cache)
    let total = 0
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i]
      if (total_cache[key].scheck) {
        total += (total_cache[key].price * 100 * total_cache[key].num * 100)
      }
    }
    let total_price = total / 10000
    this.setData({
      total_price
    })
  },
  _delCart(){
    const cart_cache = wx.getStorageSync('cart')
    const cache = wx.getStorageSync('total')
    const cache_arr = Object.keys(cache)
    for (let i = 0; i < cache_arr.length; i++) {
      let key = cache_arr[i]
      if (cache[key]['scheck']) {
         delete cart_cache[key]
      }
    } 
    wx.setStorageSync('cart', cart_cache)    
    wx.setStorageSync('total', '')
  },
  _jump_my(res){
    if (res==1){ 
      wx.showToast({
        title: "支付成功",
        icon: 'success',
        duration: 1500
      });
      setTimeout(function () {
        wx.redirectTo({
          url: '../my/index'
        });
      }, 1500);
    }else{ 
      wx.showLoading({
        title: '跳转中...',
      })
      wx.redirectTo({
        url: '../my/index'
      });
    } 
   
  },
  jumpAddress(){
    console.log(123)
    wx.navigateTo({
      url: '../my/my_address/index?op=order',
    })
  }

})