Component({
  /**
   * 组件的属性列表
   */
  properties: {
    item:Object
  },

  data: { 
  },
  methods:{
    xiadan(){
      this.triggerEvent('xiadan')
    }
  } 
  
})
