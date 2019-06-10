// components/goods/big.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    class_name: {
      type: String ,//String字符串
      value:"tag-b"
    },
    list:Object,
    catestyle:String
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
    jump(event){
      const id = event.currentTarget.dataset.id;
      wx.navigateTo({
        url: '../goods/index?id='+id
      })
    }
  }
})
