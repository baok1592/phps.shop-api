import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/animate.css'; 
import http from './common/axios.js' 

//************ common/config.js 下修改API网址*****************************

Vue.prototype.http = http	//全局调用axios 
Vue.prototype.shop_people = 'small'	//only单商户商城 small多商户商城 


Vue.config.productionTip = false; 
Vue.use(ElementUI);


//这是第一次用vue做项目，边学边做。代码很粗糙，后期会不断优化。
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
