import { OrderModel } from '../../../model/order.js'
import { PayModel } from '../../../model/pay.js' 

const orderModel = new OrderModel
const payModel = new PayModel()

Page({
 
  data: {
    set_num:0,
    total:0,
    step: 0,
    pj_content: "",
    rate: 0,
    tui_status:0,
  },
 
  onLoad: function (options) {
    wx.showLoading();
    this.id = options.id 
    this._load();
  }, 
  onShow: function () {
    wx.showLoading();
    this._load();
  }, 
  _load(){
    orderModel.get_MyOrder(this.id)    
    .then(res=>{
      console.log(res)
      const address = {}
      address['name'] = res.receiver_name
      address['mobile'] = res.receiver_mobile 
      address['city'] = res.receiver_city 
      address['detail'] = res.receiver_address  
      //res.type==1为拼团 
      if (res.type){
        this._step_pt(res)
      }else{
        this._step_pro(res)
      }
      const total = res.order_money * 100 
      this.setData({
        ...res, 
        address:address,
        total:total 
      })
      wx.hideLoading();
    })
  },
  _step_pt(res){
    let step = 0
    if (res.pay_status && !res.pt_status) {
      //已支付 待拼团成功
      step = 1
    }
    if (res.pay_status && res.pt_status && !res.drive_status) {
      //已支付 拼团成功 待发货
      step = 2
    }
    if (res.pay_status && res.drive_status && !res.receive_status) {
      //已支付 已发货
      step = 3
    }
    if (res.drive_status && res.receive_status) {
      //已发货  已收货
      step = 4
    }
    this.setData({
      step
    })
  },
  _step_pro(res) {
    let step = 0
    if (res.pay_status && !res.drive_status) {
      //已支付 未发货
      step = 1
    }
    if (res.drive_status && !res.receive_status) {
      //已支付 已发货  未收货
      step = 2
    }
    if (res.drive_status && res.receive_status) {
      //已支付 已收货
      step = 3
    }
    this.setData({
      step
    })
  },
  //支付
  onPay(event) { 
    payModel.ready(this.data.order_id).then(data => {
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
  jump_product(){
    wx.redirectTo({
      url: '../../goods/index?id=' + this.data.ordergoods[0].goods_id,
    })
  },
  rate_fun(e) {
    this.setData({
      rate: e.detail.value
    });
  },
  pj_change(e) {
    this.setData({
      pj_content: e.detail
    });
  },
  pj_sub() {
    if (this.data.rate < 1) {
      wx.showToast({
        title: '未评分',
        icon: "none"
      })
      return;
    }
    let data = {}
    data['id'] = this.id * 1
    data['rate'] = this.data.rate
    data['content'] = this.data.pj_content
    orderModel.set_pj(data).then(res => {
      wx.showToast({
        title: '操作成功',
        icon: "none",
        success: () => {
          setTimeout(() => {
            wx.redirectTo({
              url: '../index',
            })
          }, 2000)
        }
      })
    })
  },
  jump_tui(){ 
    const total = this.data.order_money
    const id = this.id
    wx.navigateTo({
      url: `../tui/index?id=${id}&total=${total}`,
    })
  },
  //确认收货
  shou_sub(){
    const id =this.id
    wx.showModal({
      title: '提示',
      content: '确认收货?',
      success(e) {
        if (e.confirm) {
          orderModel.receive(id).then(res => {
            wx.navigateBack()
          })
        } 
      }
    }) 
  }
  
})