// qycomponents/title/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    title:String,
    url:{
      type: String,
      value:""
    }
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
    jump() {
      if (this.data.url != ""){
        wx.navigateTo({
          url: this.data.url
        })
      }
    }
  }
})
