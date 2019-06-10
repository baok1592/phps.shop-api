// components/guige/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    start:Boolean,
    goods:Object,
    setNumber:Boolean,
    only:Boolean,
    price:Number
  },

  /**
   * 组件的初始数据
   */
  data: {
    sku_index:0
  },

  attached(){  
    
  },
  /**
   * 组件的方法列表
   */
  methods: {
    shut(){
      let img = this.properties.goods.sku[0].imgs ? this.properties.goods.sku[0].imgs.url : ''
      this.setData({
        start:false,
        sku_index: 0,
        'goods.imgs.url': img
      })  
    },
    selectSku(event){  
      const id = event.currentTarget.dataset.id;  
      if (this.properties.only){
        var price = this.properties.goods.sku[id].only_price
      }else{
        var price = this.properties.goods.sku[id].price
      }
      
      let img = this.properties.goods.sku[id].imgs ? this.properties.goods.sku[id].imgs.url : ''
      this.sku_ready = id
      this.setData({
        'price':price,
        'goods.imgs.url':img,
        sku_index:id
      })
      
    },
    createOrder(){
      const id = this.data.sku_index         
      this.triggerEvent("trigger",{id:id})
    }
  }
})
