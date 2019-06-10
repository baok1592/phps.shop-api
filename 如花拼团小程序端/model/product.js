/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */


import {  HTTP }  from '../util/http.js'

class ProductModel extends HTTP{
  
    getall_with_page(){
      return this.request({
        url: 'recent',
        data: { "type": "hot" }
      });
    }

    //获取热门商品
    get_hot_product(){
      return this.request({
        url:'recent',
        data: { "type":"hot"}
      });
    } 

    //获取指定商品信息
    get_product_one(id){
      return this.request({
        url: 'product/' + id
      });
    }
 
    search(name) {
      return this.request({
        url: 'search',
        method: "post",
        data: {
          name: name
        }
      });
    }
 
}

export{ ProductModel }