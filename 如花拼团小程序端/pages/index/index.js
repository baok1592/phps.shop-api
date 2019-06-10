import { BannerModel } from '../../model/banner.js'
import { ProductModel } from '../../model/product.js'
import { CategoryModel } from '../../model/category.js'
import { HTTP } from '../../util/http.js'

const bannerModel = new BannerModel()
const productModel = new ProductModel()
const categoryModel = new CategoryModel()
const http = new HTTP()

Page({
  data: {
    banner: [], 
    indicatorDots: true,
    autoplay: true,
    interval: 3000,
    duration: 1000,
    current: 'index',
    catestyle: '1',//为商品，0为拼团
    cartnum: 0 
  },  

  onLoad(){
    this._load();  
  },

  _load(){
    wx.showLoading();
    const banner_res = bannerModel.get_banner();
    const product_res = productModel.get_hot_product();
    const category_res = categoryModel.get_category();

    Promise.all([banner_res, product_res, category_res]).then(res => {
      this.setData({
        banner: res[0].items,
        products: res[1],
        category: res[2]
      })
      wx.hideLoading();
    }) 
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
  handleChange({ detail }) { 
    wx.redirectTo({
      url: "../" + detail.key+"/index"
    });
  },
  jump_goods(res){
    const id = res.detail.id;
    wx.navigateTo({
      url: "../goods/index?id="+id
    })
  },
  jump_category(event) {
    const id = event.currentTarget.dataset.id
    wx.navigateTo({
      url: "../list/index?cid=" + id
    })
  },
  /*下拉刷新页面*/
  onPullDownRefresh: function () { 
    //this._loadData(() => wx.stopPullDownRefresh());
  },
  //分享效果
  onShareAppMessage: function () {
    return {
      title: '如花拼团',
      path: 'pages/index/index'
    }
  }
  
})