import { MyModel } from '../../model/my.js'
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
    if(options.type=='pt'){
      this.buy_type = 'pt'      
    } 
    if (options.type == 'only') {
      this.buy_type = 'only'
    }   
    this._load();
  },
  onShow: function (options) {
    this._load();
    console.log(this.data.num)
  },
  _load() {
    this.msg=''
    wx.showLoading();
    const pintuan = wx.getStorageSync('pintuan'); 
    if (this.buy_type == 'pt') {
      const total = this.data.num * pintuan.price * 100
      this.setData({
        ...pintuan,
        price: pintuan.price,
        total:total
      })
    }
    if (this.buy_type == 'only'){
      const total = this.data.num * pintuan.only_price * 100
      this.setData({ 
        ...pintuan, 
        price: pintuan.only_price,
        total: total
      })
    }
    myModel.get_address_default().then(res=>{  
      if(res!=''){
        this.setData({
          address: res 
        })  
      } 
      wx.hideLoading()
    }) 

  },
  //选择商品数量
  onNumber(event){
    let num = event.detail
    let total = this.data.price * 100 * num
    this.setData({ 
      total: total,
      num: num
    }) 
  },
  onMsg(trigger){
    this.msg = trigger.detail
  },
  //组装创建订单的数据
  _setdata(){
    if (this.buy_type == 'only') {
      var typename = 'only'
    }else{
      var typename = 'pintuan'
    }
    const total = this.data.price * this.data.num
    return {
      payment_type: 'wx',
      order_from: 0,
      "number": this.data.num,
      goods_id: this.data.goods_id,
      price: this.data.price,
      shipping_money: this.data.shopping_fee,
      sku_id: this.data.sku_id ? this.data.sku_id:'',
      sku_name: this.data.sku_name ? this.data.sku_name : '',
      msg: this.msg,
      "type": typename,
      total: total
    }
  },
  //创建订单并支付
  onPay(){
    //order_from  订单来源 0为小程序
    const obj = this._setdata()
    orderModel.createOrder(obj).then(res=>{ 
      return payModel.ready(res)
    }).then(data=>{
      return payModel.pay(data)
    }).then(res=>{
      this._jump_my(1)
    }).catch(err=>{
      if(err.error_code!=10000){ 
        this._jump_my(0)
      }
    })
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
    wx.navigateTo({
      url: '../my/my_address/index?op=order',
    })
  }

})