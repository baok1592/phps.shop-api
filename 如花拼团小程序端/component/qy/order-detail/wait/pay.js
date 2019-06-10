// components/order-detail/wait/pay.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    step: Number,
    flag:Boolean
  },

  attached() {
    this.setData({
      targetTime: new Date().getTime() + 10000
    });
  },

  data: {
    targetTime: 0,
    targetTime1: 0,
    myFormat: ['时', '分', '秒'],
    myFormat1: ['天', '时', '分', '秒'],
    status: '进行中...',
    clearTimer: false
  },


  methods: { 
  }
})