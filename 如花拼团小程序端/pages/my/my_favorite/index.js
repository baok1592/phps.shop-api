import { MyModel } from '../../../model/my.js'
const myModel = new MyModel

Page({

  data: { 
    list:[]
  },

  onLoad: function (options) {
     wx.showLoading()
     this._load()
  },
  _load(){
    myModel.get_favorite()
      .then(res=>{ 
        this.setData({
          list: res.goods
        })
        wx.hideLoading()
      })
  },
  jump(event){ 
    const id = event.currentTarget.dataset.id  
    wx.navigateTo({
      url: '../../goods/index?id='+id
    }) 
  }

  
   
})