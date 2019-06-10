// components/shopping/shopping.js
Component({
  
  properties: {
    info:Object,
    key:String,
    scheck:{
      type:Boolean,
      value:true    
    },
    number:{
      type:Number,
      value:1
    }
  },
  data: {
    value1: 1,
    value2: 0.1
  },
  methods:{
    handleChange1({ detail }) {
      this.setData({
        value1: detail.value
      })
    },

    handleChange2({ detail }) {
      this.setData({
        value2: detail.value
      })
    },
    del(event){ 
      const key = event.currentTarget.dataset.id 
      this.triggerEvent('del', {key})      
    },
    onChange(e) {
      const key = e.currentTarget.dataset.id
      const price = this.properties.info.price 
      this.triggerEvent('snumber', { num: e.detail, key: key, price:price })
      this.setData({
        scheck:true,
        number: e.detail
      })
    },
    radiobox(){
      const key = this.properties.key
      const scheck = !this.properties.scheck
      this.triggerEvent('radiobox', { key, scheck })   
      this.setData({
        scheck
      })
    },
    jump() {
      const id = this.properties.info.goods_id      
      this.triggerEvent('jump_product',{id})
    }
  }
  
})
