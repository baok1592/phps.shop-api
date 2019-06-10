import axios from 'axios'
import {Api_url} from './config'  
import { Message } from 'element-ui';   
//创建axios实例
var service = axios.create({
	baseURL: Api_url,
	timeout: 5000
})

//添加请求拦截器
service.interceptors.request.use(function(config) {
	console.log('先执行请求拦截器');
	//改为缓存token
	config.headers.token = localStorage.getItem("token");
	return config
}, function(error) {
	return Promise.reject(error)
})
//添加响应拦截器
service.interceptors.response.use(function(response) {
	console.log('执行到响应拦截器')
	return response
}, function(error) {
	console.log('err' + error)
	return Promise.reject(error)
})

export default {
	//get请求
	get(url, param) {
		return new Promise((cback, reject) => {
			service({
				method: 'get',
				url,
				params: param,
			}).then(res => { //axios返回的是一个promise对象 
				var res_code = res.status.toString();
				if (res_code.charAt(0) == 2) {
					cback(res); //cback在promise执行器内部
				} else {
					console.log(res, '异常1')
				}
			}).catch(err => { 
				let msg =''
				if (!err.response) { 
					msg = "请求错误"
				} else {
					if (err.response.status == 401) {
						localStorage.clear(); //结果为401，表示无权限，或token过期；返回login页面
						location.href = './#/login';
					}					 
					console.log(err.response, '异常2')
					msg = err.response.data.msg
				}				
				Message({
					showClose: true,
					message: msg,
					type: 'error'
				});
			})

		})
	},

	put(url, param) {
		return new Promise((cback, reject) => {
			service({
				method: 'put',
				url,
				params: param,
			}).then(res => { //axios返回的是一个promise对象			
				var res_code = res.status.toString();
				if (res_code.charAt(0) == 2) {
					cback(res); //cback在promise执行器内部
				} else {
					console.log(res, '异常1')
				}
			}).catch(err => {
				if (err.response.status == 401) {
					localStorage.clear();
					location.href = './#/login';
				} 
				//reject(err.response);
				console.log(err.response, '异常2')
				Message({
					showClose: true,
					message: err.response.data.msg,
					type: 'error'
				});
			})
		})
	},

	post(url, param) {
		const that = this
		return new Promise((cback, reject) => {
			service({
				method: 'post',
				url,
				data: param,
			}).then(res => {
				var res_code = res.status.toString();
				if (res_code.charAt(0) == 2) {
					cback(res); //cback在promise执行器内部
				} else {
					console.log(res, '异常1')
				}
			}).catch(err => {
				if (err.response.status == 401) {
					localStorage.clear();
					location.href = './#/login';
				} 
				Message({
					showClose: true,
					message: err.response.data.msg,
					type: 'error'
				});
				console.log(err.response, '异常2')
			})
		})
	}
}
