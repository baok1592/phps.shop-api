/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import {  HTTP }  from '../util/http.js'

class CategoryModel extends HTTP{
    
    get_category(){
      return this.request({
        url:'category/1' 
      });
    } 
    get_category_product(cid) {
    return this.request({
      url: 'category/' + cid + '/products',
    });
  } 
}

export { CategoryModel }