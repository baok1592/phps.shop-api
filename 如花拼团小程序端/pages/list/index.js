import { CategoryModel } from '../../model/category.js'

const categoryModel = new CategoryModel()


Page({

  data: {
    current_scroll: 1,
    category_list:[], 
    flag: 'product',
    current: 'list',
    catestyle:'',
    cartnum: 0 
  },

  onLoad (options) {
    wx.showLoading()
    this.category_id = options.cid

    wx.setNavigationBarTitle({ title: '所有商品' })
    if (options.type=='pt'){
      wx.setNavigationBarTitle({ title: '拼团专区' })
      this.setData({
        flag: 'pt',
        catestyle:'0'
      })      
    }    
    if (options.type == 'product') {
      wx.setNavigationBarTitle({ title: '商品专区' })
      this.setData({
        flag: 'product',
        catestyle: '1'
      })
    } 
    this._load() 
  }, 
  _load() { 
    categoryModel.get_category().then(res => {
      this.setData({
        category_list: res 
      })    
      const cid = res[0].category_id
      if (this.category_id > 0) {
        this.setData({
          current_scroll: this.category_id
        })
        return categoryModel.get_category_product(this.category_id)
      }else{
        return categoryModel.get_category_product(cid)
      }      
    }).then(res=>{
      this.setData({
        list: res
      })
      wx.hideLoading()
    })  
    this._getCartNum()
  },
  //购物车数量
  _getCartNum() {
    const cart = wx.getStorageSync('cart')
    const cache_key = Object.keys(cart)
    this.setData({
      cartnum: cache_key.length
    })
  },  
  handleChange({ detail }) {
    wx.redirectTo({
      url: "../" + detail.key + "/index"
    });
  },
  //切换分类
  handleChangeScroll({ detail }) { 
    wx.showLoading()
    this.setData({
      current_scroll: detail.key
    });
    //如果数据是第一次请求     
    categoryModel.get_category_product(detail.key).then(res => {
      this.setData({
        list: res
      })
      wx.hideLoading()
    }) 
  }

})