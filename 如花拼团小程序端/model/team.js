/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import {  HTTP }  from '../util/http.js'

class TeamModel extends HTTP{
    
  get_team(id){
      return this.request({
        url: 'product/' + id + '/item'
      }); 
    } 
}

export { TeamModel }