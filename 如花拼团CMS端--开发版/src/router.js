import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

const routelist = [{
		path: '/',
		name: 'home',
		component: () => import('./views/home/Home.vue'),
		meta: {
			title: '首页',
			icon: 'el-icon-location'
		}
	},
	{
		path: '/',
		name: 'product',
		meta: {
			title: '商品',
			icon: 'el-icon-location'
		},
		children: [{
				path: '/list',
				name: 'product_list',
				component: () => import('./views/product/List.vue'),
				meta: {
					title: '商品列表'
				}
			},
			{
				path: '/good',
				name: 'product_add',
				component: () => import('./views/product/Good.vue'),
				meta: {
					title: '商品发布'
				}
			},
			{
				path: '/category',
				name: 'product_category',
				component: () => import('./views/product/Category.vue'),
				meta: {
					title: '商品分类'
				}
			}
		]
	},  
	{
		path: '/',
		name: 'order_cai',
		meta: {
			title: '订单/财务',
			icon: 'el-icon-location'
		},
		children: [{
				path: '/order',
				name: 'order_list',
				component: () => import('./views/order/Order.vue'),
				meta: {
					title: '订单管理'
				}
			},
			{
				path: '/customer',
				name: 'order_set',
				component: () => import('./views/order/Customer.vue'),
				meta: {
					title: '财务管理'
				}
			}
		]
	}, {
		path: '/',
		name: 'member',
		meta: {
			title: '会员',
			icon: 'el-icon-location'
		},
		children: [{
			path: '/member',
			name: 'member_list',
			component: () => import('./views/member/Member.vue'),
			meta: {
				title: '会员列表'
			}
		}]
	}, {
		path: '/',
		name: 'cset',
		meta: {
			title: '设置',
			icon: 'el-icon-location'
		},
		children: [{
				path: '/ad',
				name: 'ad_list',
				component: () => import('./views/web/Ad.vue'),
				meta: {
					title: '广告管理'
				}
			},
			{
				path: '/article',
				name: 'article_list',
				component: () => import('./views/web/Article.vue'),
				meta: {
					title: '文章管理'
				}
			},
			{
				path: '/set',
				name: 'site_set',
				component: () => import('./views/web/Set.vue'),
				meta: {
					title: '站点管理'
				}
			}, {
				path: '/group',
				name: 'group',
				component: () => import('./views/group/index.vue'),
				meta: {
					title: '管理员'
				}
			}
		]
	}, {
		path: '/main',
		name: 'Main',
		component: () => import('./views/home/components/Main.vue')
	}, {
		path: '/message',
		name: 'Message',
		component: () => import('./views/member/Message.vue')
	}, {
		path: '/details',
		name: 'Details',
		component: () => import('./views/order/Details.vue'),
	}, {
		path: '/login',
		name: 'Login',
		component: () => import('./views/login/Login.vue')
	}, {
		path: '/lout',
		name: 'lout',
		component: () => import('./views/login/lout.vue')
	}, {
		path: '*',
		redirect: './views/404'
	}
]

export default new Router({  
	routes: routelist
})
