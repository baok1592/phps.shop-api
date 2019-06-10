// components/address/index.js
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
    edit(event){
      const id = event.currentTarget.dataset.id
      this.triggerEvent('edit',id)
    },
    del(event) {
      const id = event.currentTarget.dataset.id
      this.triggerEvent('del', id)
    },
    setDefault(event){
      const id = event.currentTarget.dataset.id
      this.triggerEvent('setd',id)
    },
    selectDefault(event) {
      const id = event.currentTarget.dataset.id
      this.triggerEvent('sstd', id)
    },
  }
})
