import { HTTP } from '../../../../util/http.js'
const http = new HTTP 

Page({

  data: { 
  },

  onLoad: function (options) {
    wx.showLoading()
    this.id = options.id
    this._load();
  },
  _load() { 
    http.request({
      url: 'newlist/' + this.id
    }).then(res=>{
      this.setData({
        ...res
      })
      wx.hideLoading()
    }) 
  }
})