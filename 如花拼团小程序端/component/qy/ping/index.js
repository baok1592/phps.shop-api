// component/qy/ping/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    list:Object
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
    ct_show({currentTarget}){
      const index = currentTarget.dataset.index 
      this.triggerEvent('cantuan',index)      
    }
  }
})
