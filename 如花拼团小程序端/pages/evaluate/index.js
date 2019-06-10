import {HTTP} from '../../util/http.js'
const http = new HTTP
Page({

  /**
   * 页面的初始数据
   */
  data: {
    starIndex4: 4 
  },
  onLoad(options){
    this._load(options.id)
  },
  _load(id){
    http.request({
      url: 'product/evaluate/'+id
    }).then(res=>{
      this.setData({
        list:res
      })
    });
  }


})