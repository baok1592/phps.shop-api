/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import {  HTTP }  from '../util/http.js'

class FavoriteModel extends HTTP{
    
    check_favorite(id){
      return this.request({
        url: 'favorite/get_one',
        method: 'post',
        data: { id: id }
      });
    }

    add(data) {
      return this.request({
        url: 'favorite/add',
        method: 'post',
        data: data
      });
    }

    del(id) {
      return this.request({
        url: 'favorite/del',
        method: 'post',
        data: { id: id }
      });
    } 
}

export { FavoriteModel }