// components/shopping-foot/footer.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    price:Number,
    scheck: {
      type: Boolean,
      value: true
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
    select(){
      let scheck = !this.data.scheck 
      this.setData({
        scheck
      })
      this.triggerEvent('onselect',{scheck:scheck})
    },
    submit(){
      this.triggerEvent('sub')
    }
  }
})
