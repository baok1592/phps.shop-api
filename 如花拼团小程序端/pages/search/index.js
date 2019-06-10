import { ProductModel } from '../../model/product.js'

const productModel= new ProductModel

Page({
  data: {
    value: '',
    controlled:false,
    list:[],
    num:1,
    twobtn:true
  },  
  onBlur(e) {
    const key = e.detail.value
    productModel.search(key).then(res=>{      
      this.setData({
        list:res,
        num: res.length,
        twobtn:false
      })
    })
  },
  onChange(e) {
    console.log('onChange', e)
    this.setData({
      value: e.detail.value,
    })
  }, 
  onCancel(e) {
    console.log('onCancel', e)
    this.setData({
      controlled: true,
      value: '',
      list:[],
      num:1
    })
  },
  jump_pt(){
    wx.navigateTo({
      url: '../list/index?type=pt',
    })
  },
  jump_pd() {
    wx.navigateTo({
      url: '../list/index?type=product',
    })
  }
})
