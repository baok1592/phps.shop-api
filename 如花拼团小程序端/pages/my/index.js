import { Common } from '../../util/common.js';
const common = new Common

Page({

  data: {
    current: 'my',
    url:'my_order_all/index',
    cartnum:0
  },

  onLoad: function(options) {
    this.check_userAuth() 
    this._getCartNum()
  }, 
  //购物车数量
  _getCartNum(){
    const cart = wx.getStorageSync('cart')
    const cache_key = Object.keys(cart) 
    this.setData({
      cartnum: cache_key.length
    })
  },
  check_userAuth() {
    const that = this;
    wx.getSetting({
      success: data => {
        if (data.authSetting['scope.userInfo']) {   
          const user = wx.getStorageSync('usercache')
          if (common._CheckCacheTime(user.create_time)){   
            that.setData({
              userinfo: user
            })            
          } else { 
            wx.getUserInfo({
              success: data => {
                that.setData({
                  userinfo: data.userInfo
                })
                common._set_usercache(data.userInfo)
              }
            })
          }
        } else {
          that.setData({
            login: true
          })
        }
      }
    })
  },

  handleChange({ detail }) {
    wx.redirectTo({
      url: "../" + detail.key + "/index"
    });
  },
  orderjump() {
    wx.navigateTo({
      url: "my_order_all/index"
    });
  },

  GetUserInfo(event) {
    const userinfo = event.detail.userInfo
    if (userinfo) { 
      this.setData({
        userinfo
      }) 
      common._set_usercache(userinfo)  
      let ab = http.request({
        url:'register',
        method:'post',
        data: {
          nickname: userinfo.nickName,
          headpic: userinfo.avatarUrl
        }
      })
      ab.then(res=>{
        console.log(res)
      }) 
    } 
  },

 
})