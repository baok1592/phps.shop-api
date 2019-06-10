// component/qy/oauth/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    login: Boolean
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
    updateUserInfo(result) {
      this.setData({
        login: false
      }) 
      this.triggerEvent('userinfo', result.detail)
    } 
  }
})
