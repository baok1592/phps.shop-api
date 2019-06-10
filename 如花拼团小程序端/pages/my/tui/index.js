import { OrderModel } from '../../../model/order.js' 
const orderModel = new OrderModel

Page({
 
  data: { 
    content:"",
    yy:['多拍了','不想买了','其他']
  },
  onLoad(options){
    this.setData({
      total: options.total,
      id:options.id
    })
  },
  radio(e){ 
    const name=e.currentTarget.dataset.name
    this.setData({
      radio:name
    })
  },
  content(event){
    this.setData({
      content: event.detail
    })
  },
  //申请退款
  sub(){
    if (this.data.radio == undefined || this.data.radio == null) {
      wx.showToast({
        title: '请选择退款原因',
        icon: "none"
      })
      return;
    }
    let obj={
      id:this.data.id, 
      radio: this.data.yy[this.data.radio],
      content: this.data.content,
    }  
    orderModel.tuikan(obj).then(res => {
      if (res == 1) {
        wx.showToast({
          title: '已提交待审核',
          icon: "none"
        }) 
        setTimeout(()=>{
          wx.navigateBack()
        },1000)        
      }
    })
  } 
})