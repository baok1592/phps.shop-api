// components/myorder/myorder.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    url:String
  },

  /**
   * 组件的初始数据
   */
  data: {

  },

  /**
   * 组件的方法列表
   */
   methods: {
    jump(event) {  
      this.triggerEvent('orderjump')
    },
    all(){
      wx.navigateTo({
        url: this.properties.url+"?ct=0"
      })
    },
    pay(){
      wx.navigateTo({
        url: this.properties.url + "?ct=1"
      })
    },
    drive() {
      wx.navigateTo({
        url: this.properties.url + "?ct=2"
      })
    },
    end() {
      wx.navigateTo({
        url: this.properties.url + "?ct=3"
      })
    }

  }
})
