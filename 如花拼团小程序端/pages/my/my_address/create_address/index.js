import city from "../../../../util/city.js"
import { MyModel } from '../../../../model/my.js'
const myModel = new MyModel

Page({
  data: {
    options: city,
    value: [],
    edit:false
  },
  onLoad(options){
    if (options.id) {
      wx.showLoading() 
      this.id = options.id
      this._load()
    }
  },
  _load(){
    myModel.get_address_one(this.id).then(res=>{
      this.setData({
        ...res
      })
      wx.hideLoading()
    })
  },
  onOpen() {
    this.setData({ visible: true })
  },
  onClose() {
    this.setData({ visible: false })
  },
  onChange(e) {
    this.setData({ city: e.detail.options.map((n) => n.label).join('') }) 
  }, 
  formSubmit: function (event) {
    let address = event.detail.value
    address['city'] = this.data.city 
    myModel.CreateAddress(address, this.id)
    .then(res=>{
      wx.showToast({
        title: '成功',
        icon: 'success',
        duration: 1500
      }) 
      setTimeout(function(){
        wx.navigateBack({
        })
      },1500) 
    })
  }
})