// qycomponents/t-product/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
      info:{
        type:Object  
      }
  },

  /**
   * 组件的初始数据
   */
  data: {

  },

  attached:function(){
     
  },
  /**
   * 组件的方法列表
   */
  methods: {
    jump(event){ 
      const id = event.currentTarget.dataset.id;
      this.triggerEvent('gjump',{id},{}) 
    }
  }
})
