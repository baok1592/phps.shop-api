import { HTTP } from '../../../util/http.js'
const http = new HTTP

Page({

  data: { 
  },

  onLoad: function (options) { 
    wx.showLoading()
    this._load();
  },
  _load() {
    http.request({
      url: 'newlist'
    }).then(res=>{
      this.setData({
        list:res
      })
      wx.hideLoading()
    })
  }
})