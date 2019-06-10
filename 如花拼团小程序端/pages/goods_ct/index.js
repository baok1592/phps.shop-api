import { OrderModel } from '../../model/order.js'
import { PayModel } from '../../model/pay.js'
const orderModel = new OrderModel()
const payModel = new PayModel()

Page({

  data: {
  },
  onLoad(options) {
    this._load()
  },
  _load(id) {
    const cache = wx.getStorageSync('cantuan') 
    this.setData({
      cache: cache
    })
  },
  xiadan(){
    wx.showToast({
      title: '演示',
      icon:'none'
    })
  }, 
})