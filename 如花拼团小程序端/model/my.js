/**
 * 如花拼团开源系统 -- 永久免费  Version：1.0.2 
 * 官方网址：http://www.phps.shop  作者：光爵  QQ 交流群：728615087 
 */

import { HTTP }  from '../util/http.js'

class MyModel extends HTTP{

    //获取所有收藏
    get_favorite(){
      return this.request({
        url: 'favorite/get_all',
        method: 'post', 
      });
    } 
    //获取所有地址
    get_address() {
      return this.request({
        url: 'address/all', 
        method: 'post',
      });
    } 
    //获取授权地址
    get_address_default() {
      return this.request({
        url: 'address/get_default', 
        method: 'post',
      });
    } 
    //获取指定地址
    get_address_one(id) {
      return this.request({
        url: 'address/one',
        method: 'post',
        data: { id: id }
      });
    }

    //设置授权地址
    setDefault(id){
      return this.request({
        url: 'address/set_default',
        method: 'post',
        data: { id: id }
      });
    }

    CreateAddress(address,oid){
      if (oid){
        var url = 'address/up'
        address['id']=oid
      }else{
        var url = 'address'
      }      
      console.log(address)
      return this.request({
        url:url,
        method:'post',
        data: address
      })
    }

    del_address(id){
      return this.request({
        url: 'address/del',
        method: 'post',
        data: { id: id }
      })
    }
}

export { MyModel }