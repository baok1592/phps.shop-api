import { config } from '../config.js' 

class HTTP {
  
  request({ url, data = {}, method = 'GET' }) {
    return new Promise((resolve, reject) => {
      this._request(url, resolve, reject, data, method)
    })
  }
  _request(url, resolve, reject, data, method) {
    wx.request({
      url: config.api_base_url + url,
      method: method,
      data: data,
      header: {
        'content-type': 'application/json',
         token: wx.getStorageSync('token')
      },
      success: (res) => {
        const code = res.statusCode.toString()
        if (code.startsWith('2')) {
          resolve(res.data)
        }
        else {
          reject(res.data) 
          const error_code = res.data.error_code 
          if (error_code == 10000){
            if (typeof res.data.msg == 'object') {
              const arr = Object.values(res.data.msg) 
              const str = JSON.stringify(arr)
              this._show_error(str)
            }else{
              this._show_error(res.data.msg)
            }            
          }else{
            this._show_error()
          }
        }
      },
      fail: (err) => {
        reject(err)
        this._show_error()
      }
    })

  }

  _show_error(msg ='请求发生错误') {
    wx.showToast({
      title: msg,
      icon: 'none',
      duration: 2000
    })
  }


}

export { HTTP } 