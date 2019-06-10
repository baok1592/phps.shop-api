import { ProductModel } from '../../model/product.js'
import { FavoriteModel } from '../../model/favorite.js'
import { TeamModel } from '../../model/team.js'
import { Common } from '../../util/common.js';
import { HTTP } from '../../util/http.js';
const WxParse = require('../../lib/wxParse/wxParse.js');

const productModel = new ProductModel
const favoriteModel = new FavoriteModel
const teamModel = new TeamModel
const common = new Common
const http = new HTTP

Page({ 
  data: {
    imgUrls: [],
    favorite:0,
    indicatorDots: true,
    autoplay: true,
    interval: 5000,
    duration: 1000,
    login:false,
    skubox: false,
    only:false
  }, 
  onLoad: function (options) {
    this.id = options.id;    
    this._load();
  },
  _load() {
    wx.showLoading();
    const favorite = favoriteModel.check_favorite(this.id)
    const goods = productModel.get_product_one(this.id)
    const team = teamModel.get_team(this.id) 

    Promise.all([favorite, goods, team])
    .then(res => {  
      WxParse.wxParse('contents', 'html', res[1].content, this, 5);    
      this.setData({
        favorite: res[0],
        goods:res[1],
        team:res[2],
        imgUrls:[res[1].imgs]
      })  
      console.log(res[1])
      wx.hideLoading();
      if (res[1].sku.length > 0) { 
        this.setData({
          'goods.price': res[1]['sku'][0]['price'],
          'goods.only_price': res[1]['sku'][0]['only_price'],
        }) 
      }
    })     
  }, 
  //拼团单独购买 
  OnlyShopping() { 
    this.setData({
      only:true
    })
    this.onOrder()
  },
  //拼团购买
  onPinTuan(){ 
    this.setData({
      only: false
    })
    this.onOrder()
  },

  //商品单独购买 
  Shopping() {
    this.fangshi = 'shopping'
    this.onOrder()
  },
  Cantuan_auth(trigger){
    const auth = this.check_userAuth() //检查是否授权
    const index = trigger.detail
    auth.then(res => {
      if (res) { 
        wx.setStorageSync('cantuan', this.data.team[index])
        wx.navigateTo({
          url: '/pages/goods_ct/index',
        })
      } else {
        this.setData({
          login: true
        })
      }
    })
  },
  //判断购物车商品
  intoCart() {
    this.fangshi = 'cart'
    const auth = this.check_userAuth() //检查是否授权
    auth.then(res => {
      if (res) {
        if (this._is_sku()) {
          this._GotoCart(-1)  //无规格加入购物车
        }
      } else {
        this.setData({
          login: true
        })
      }
    })
  },
  //检查数据
  onOrder() {
    const auth = this.check_userAuth() //检查是否授权
    auth.then(res => {
      if (res) {
        if(this._is_sku()){
          if (this.data.goods.style == 0) {
            this.GotoOrder(-1)  //无规格下单
          }
          if (this.data.goods.style == 1) {
            this._GotoCart(-1)   //无规格加入购物车
            wx.redirectTo({
              url: '../cart/index',
            })
          }
        }        
        //有规格跳出弹框，选择触发别的下单函数
      } else {
        this.setData({
          login: true
        })
      }
    })
  },
  //判断是否需要选择规格
  _is_sku(){ 
    if (this.data.goods.sku.length > 0) {
      const that = this
      if (this.data.only) {
        this.setData({
          skubox: true,
          sku_price: that.data.goods.sku[0]['only_price']
        })
      } else {
        this.setData({
          skubox: true,
          sku_price: that.data.goods.sku[0]['price']
        })
      }
      return false
    }else{
      return true
    }
  },
  //检测是否授权
  check_userAuth() { 
    return new Promise((resolve, reject) => {
      wx.getSetting({ 
        success: (res) => { 
          resolve(res.authSetting['scope.userInfo']);         
        } 
      })
    })
  }, 

  //用户授权信息放入缓存，并向API发送
  GetUserInfo(event) { 
    const userinfo = event.detail.userInfo
    if (userinfo) { 
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
  
  //选择规格
  selectSku(event){
    const id = event.detail.id
    if(this.data.goods.style == 0){
      this.GotoOrder(id)
    }
    if (this.data.goods.style == 1) {
      this._GotoCart(id)
      if (this.fangshi=='shopping'){
        wx.redirectTo({
          url: '../cart/index',
        })
      }
    }
  },
  //组合数据后去下单
  GotoOrder(sku_id){
    const arr = this._setOrderData(sku_id)
    wx.setStorageSync('pintuan', arr)
    if(this.data.only){
      wx.navigateTo({
        url: '../pay/index?type=only'
      })
    }else{
      wx.navigateTo({
        url: '../pay/index?type=pt'
      })
    }
  },
   //组合数据
  _setOrderData(sku_index) {
    const goods = this.data.goods
    let arr = {};
    arr['goods_id'] = goods.goods_id
    arr['goods_name'] = goods.goods_name
    arr['shopping_fee'] = goods.shipping_fee
    if (sku_index >= 0) {
      arr['sku_id'] = goods.sku[sku_index].sku_id
      arr['sku_name'] = goods.sku[sku_index].sku_name
      arr['img'] = goods.sku[sku_index].imgs ? goods.sku[sku_index].imgs.url : ''
      arr['price'] = goods.sku[sku_index].price
      arr['only_price'] = goods.sku[sku_index].only_price
    } else {
      arr['img'] = goods.imgs ? goods.imgs : ''
      arr['price'] = goods.price
      arr['only_price'] = goods.only_price
    } 
    return arr
  },
  //将商品加入购物车
  _GotoCart(sku_index){
    wx.showLoading()
    let arr = {}
    var cache_id = this.data.goods.goods_id
    if (sku_index>=0){
      cache_id = cache_id + '-' + this.data.goods.sku[sku_index].sku_id
    }
    const cache_obj = wx.getStorageSync('cart')
    const cache_key = Object.keys(cache_obj) 

    if (cache_key.length > 0){    
      for (let i = 0; i < cache_key.length;i++){
        let key = cache_key[i]
        if (cache_id == key){
          wx.showToast({
            title: '已存在',
            icon: 'none'
          })
          return 
        }
        arr[key] = cache_obj[key]
      }
    }   
    arr[cache_id] = this._setOrderData(sku_index) 
    wx.setStorageSync('cart', arr)
    wx.hideLoading()
    wx.showToast({
      title: '加入成功',
      icon:'success'
    })
    this.setData({
      skubox: false
    })        
  },
  //收藏与取消收藏
  onFavorite() {
    if (this.data.favorite == 0) {
      let data = {}
      data['fav_id'] = this.id
      data['type'] = 'goods'
      data['price'] = this.data.goods.price 
      favoriteModel.add(data).then(res => {
        wx.showToast({
          title: '收藏成功',
          icon: 'success'
        })
        this.setData({
          favorite: 1
        })
      })
    } else {
      favoriteModel.del(this.id)
        .then(res => {
          wx.showToast({
            title: '取消成功',
            icon: 'success'
          })
          this.setData({
            favorite: 0
          })

        })
    }
  }, 
  //分享
  onShareAppMessage: function () {
    return {
      title: this.data.goods.goods_name,
      path: 'pages/index/index'
    }
  }
   
})