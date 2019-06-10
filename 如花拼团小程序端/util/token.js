import { config } from '../config.js';

class Token {
  constructor() {
    this.tokenUrl = config.api_base_url + 'token'; 
    this.verifyUrl = config.api_base_url + 'token/verify';
  }
  
  verify() {
    var token = wx.getStorageSync('token');//获取缓存
    if (!token) { 
      this.getTokenFromServer();//向微信api拿code，再向tp的api拿token
    }
    else { 
      this._veirfyFromServer(token);//验证token是否过期，过期调用.getTokenFromServer函数获取
    }
  }
  //验证token
  _veirfyFromServer(token) {
    var that = this;
    wx.request({
      url: that.verifyUrl,
      method: 'POST',
      data: {
        token: token
      },
      success: function (res) {
        var valid = res.data.isValid;
        if (!valid) {
          that.getTokenFromServer();
        }
      }
    })
  }
  //获取Token
  getTokenFromServer(callBack) { 
    var that = this;
    wx.login({
      success: function (res) {
        wx.request({
          url: that.tokenUrl,
          method: 'POST',
          data: {
            code: res.code
          },
          success: function (res) {
            wx.setStorageSync('token', res.data.token);
            callBack && callBack(res.data.token);
          }
        })
      }
    })
  }
}

export { Token };