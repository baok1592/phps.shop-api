import { MyModel } from '../../../model/my.js'
const myModel = new MyModel

Page({

  data: { 
  },

  onLoad: function (options) {
    wx.showLoading() 
    this._load()
  },
  onShow: function (options) {
    wx.showLoading() 
    this._load()
  },
  _load() {
    myModel.get_address()
      .then(res => {
        this.setData({
          list:res
        }) 
        wx.hideLoading()
      })
  },
  jump(){
    wx.navigateTo({
      url: 'create_address/index',
    })
  },
  del(trigger){
    const id = trigger.detail;
    myModel.del_address(id).then(res=>{
      this._load()
      wx.showToast({
        title: '成功',
        icon: 'success',
        duration: 2000
      }) 
    })
  }, 
  edit(trigger) {
    const id = trigger.detail;
    wx.navigateTo({
      url: 'create_address/index?id='+id
    }) 
  },
  //设置默认地址
  setDefault(trigger) { 
    const id = trigger.detail
    myModel.setDefault(id).then(res=>{ 
      wx.showToast({
        title:'成功',
        icon:'success'
      })  
      setTimeout(function () {
        wx.navigateBack({
        })
      }, 1000)         
    })
    
  },
  //点击默认地址本身
  selectdefault(trigger) {  
    setTimeout(function () {
      wx.navigateBack({
      })
    }, 1000)
  },

})