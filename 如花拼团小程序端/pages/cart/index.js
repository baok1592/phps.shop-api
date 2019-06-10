import { OrderModel } from '../../model/order.js'
import { PayModel } from '../../model/pay.js'

const orderModel = new OrderModel()
const payModel = new PayModel()

Page({

  data: {
    current: 'cart',
    total:0,
    scheck:true,
    c_number:1,
    cartnum: 0 
  },

  onLoad: function (options) {
   this._load()
  },
  _load(){
    const cart = wx.getStorageSync('cart')
    this.setData({
      list: cart,
      c_number:1,
      scheck: true,
    })
    const cart_arr = Object.keys(cart)

    var total = {}
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i]
      total[key] = { price: cart[key]['price'], num: 1, scheck: true }
    }
    wx.setStorageSync('total', total)
    this._count_price()
    this._getCartNum()
  },
  //购物车数量
  _getCartNum() {
    const cart = wx.getStorageSync('cart')
    const cache_key = Object.keys(cart)
    this.setData({
      cartnum: cache_key.length
    })
  },
  //tab切换
  handleChange({ detail }) {
    wx.redirectTo({
      url: "../" + detail.key + "/index"
    });
  },
  //加减按钮
  snumber(trigger){
    const cart_total = wx.getStorageSync('total')
    const skey = trigger.detail.key
    const num = trigger.detail.num
    const price = trigger.detail.price 
    const cart_arr = Object.keys(cart_total)  

    var total = cart_total
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i] 
      if (skey == key){
        total[skey] = { price,num,scheck:true}
      } else{
        total[skey] = { price, num, scheck: true }
      }
    }
    wx.setStorageSync('total', total) 
    this._count_price() 
  },
  //计算勾选商品的总价
  _count_price(){
    const total_cache = wx.getStorageSync('total') 
    const cart_arr = Object.keys(total_cache) 
    let total = 0
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i]
      if (total_cache[key].scheck){
        total += (total_cache[key].price*100 * total_cache[key].num*100)
      }
    }
    let total_price = total/10000 
    this.setData({
      total_price
    })
  },
  //全选
  onselect(trigger){
    var scheck = trigger.detail.scheck 
    const total_cache = wx.getStorageSync('total')
    const cart_arr = Object.keys(total_cache) 
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i]
      total_cache[key]['scheck'] = scheck
    }
    wx.setStorageSync('total', total_cache)
    this.setData({
      scheck 
    })
    this._count_price()
  },
  //单商品勾选
  radiobox(trigger){
    var scheck = trigger.detail.scheck
    var skey = trigger.detail.key
    const total_cache = wx.getStorageSync('total')
    const cart_arr = Object.keys(total_cache)
    for (let i = 0; i < cart_arr.length; i++) {
      let key = cart_arr[i]
      if (key==skey){
        total_cache[key]['scheck'] = scheck
      } 
    }
    wx.setStorageSync('total', total_cache)  
    this._count_price()   
  },
  //去下单
  sub(){
    wx.redirectTo({
      url: '../pay_shopping/index',
    })
  },   
  
  //删除商品  
  del(trigger) {
    const key = trigger.detail.key
    const cart = wx.getStorageSync('cart')
    const total = wx.getStorageSync('total')
    delete cart[key];
    delete total[key];
    wx.setStorageSync('cart', cart)
    wx.setStorageSync('total', total)
    wx.showToast({
      title: '删除成功',
      icon: 'success'
    })
    this._load()
  },
  //跳转商品详情
  jump_product(trigger){
    const id = trigger.detail.id
    wx.navigateTo({
      url: '../goods/index?id='+id,
    })
  }
  

})