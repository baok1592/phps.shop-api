<template>
	<div id="home"> 
		<el-container v-if="isshow">
			<el-aside width="200px">
				<el-col :span="24">
					<el-menu class="el-menu-vertical-demo" unique-opened="true"
					 background-color="#545c64" text-color="#fff"
					 active-text-color="#ffd04b">
						<template v-for="(item,index) in routers">

							<el-menu-item index="0" v-if="item.name == 'home'" @click="nav('Main')">
								<span slot="title">首页</span>
							</el-menu-item>
							<template v-if="rbac.indexOf(item.name)>=-10">
							<el-submenu :index="index" v-if="item.meta && item.name != 'home'">
								<template slot="title">
									<span>{{item.meta.title}}</span>
								</template>
								<el-menu-item-group v-if="item.name!='home'">
									<template v-for="(child,cindex) in item.children">
										<template v-if="rbac.indexOf(child.name)>=-10">
										<el-menu-item :index="index+'-'+cindex" @click="nav(child.name)">
											{{child.meta.title}}
										</el-menu-item>
										</template>
									</template>
								</el-menu-item-group>
							</el-submenu>
							</template>
						</template>


					</el-menu>
				</el-col>
				</el-row>

			</el-aside>
			<el-container>
				<el-header style='border-bottom: 1px solid #e0e0e0;'>
					<home-header></home-header>
				</el-header>
				<el-main style='background-color: #ffffff;'>
					<component :is="comview" />
				</el-main>
			</el-container>
		</el-container>
	</div>
</template>

<script>
	// @ is an alias to /src
	import HomeHeader from './components/Header.vue'
	import Main from './components/Main.vue'
	import product_list from '../product/List.vue'
	import product_add from '../product/Good.vue'	 
	import product_category from '../product/Category.vue'  
	import order_list from '../order/Order.vue' 
	import member_list from '../member/Member.vue' 
	import article_list from '../web/Article.vue'
	import site_set from '../web/Set.vue'
	import ad_list from '../web/Ad.vue' 
	import group from '../group/index.vue'
	import HomeSpec from '../product/Spec.vue'
	import order_set from '../order/Customer.vue'
	

	export default {
		name: 'home',
		data() {
			return {
				comview: 'Main',
				isshow: false,
				routers: this.$router.options.routes,
				rbac:[]
			}
		},
		components: {
			HomeHeader,
			Main,
			product_list,
			product_add,
			product_category, 
			HomeSpec, 
			order_list,
			order_set, 
			member_list,
			group, 
			article_list,
			site_set,
			ad_list,  
		},
		methods: {
			nav(name) {
				console.log(name)
				this.comview = name
			},
			login() {
				this.http.get('/admin/check_login')
					.then((res) => {
						this.isshow = true 
					});
			}
		},
		mounted() {			 
			const oauth=localStorage.getItem("oauth"); 
			this.rbac=oauth
			this.login();  
		}
	}
</script>
<style lang="less">
	#home {
		.el-menu-item-group .el-menu-item {
			background: #434A50 !important;
		}

		.el-menu-item.is-active {
			color: #409EFF !important;
		}

		.home {
			height: 100%;
			overflow: hidden;
			background: #fff;
		}

		.el-header,
		.el-footer {
			background-color: #ffffff;
			color: #333;
			text-align: center;
			line-height: 60px;
		}

		.el-aside {
			background-color: #D3DCE6;
			color: #333;
			text-align: center;
			line-height: 200px;
		}

		.el-main {
			background-color: #E9EEF3;
			color: #333;
			text-align: center;
			line-height: 160px;
		}

		body>.el-container {
			margin-bottom: 40px;
		}

		.el-container:nth-child(5) .el-aside,
		.el-container:nth-child(6) .el-aside {
			line-height: 260px;
		}
	}
</style>
