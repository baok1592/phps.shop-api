<template>
	<div id="create">
		<div class="release">
			<el-form ref="forms" :model="forms" label-width="120px">
				<el-form-item label="组名称">
					<el-input v-model="group_name" style='width:500px'></el-input>
				</el-form-item>
				<el-form-item label="权限设置">
					<el-tree :data="data2" show-checkbox node-key="name" :default-expanded-keys="zhankai" :default-checked-keys="checked"
					 :props="defaultProps" ref="tree">
					</el-tree>
				</el-form-item>
				<el-form-item></el-form-item>
				<el-form-item>
					<el-button @click="sub" v-if="eid<1" type="primary">提交</el-button> 
					<el-button v-else type="success" @click="onEdit">修改</el-button>
				</el-form-item>
			</el-form>
		</div>

	</div>

</template>

<script>
	export default { 
		props: ['eid'],
		data() {
			return {
				zhankai: ['product', 'shop', 'chou', 'order_cai', 'member', 'cset'],
				checked: ['product/add', 'product/list'],
				group_name:"",
				sku_table: false,
				sub_btn: true,
				data2: [{
					label: '全选',
					name: 'all',
					children: [{
						label: '商品',
						name: 'product',
						children: [{
							label: '商品列表',
							name: 'product_list'
						}, {
							label: '商品发布',
							name: 'product_add'
						}, {
							label: '商品删除',
							name: 'product_del'
						}, {
							label: '商品分类',
							name: 'product_category'
						}]
					}, {
						label: '订单/财务',
						name: 'order_cai',
						children: [{
							label: '订单列表',
							name: 'order_list'
						}, {
							label: '售后服务',
							name: 'order_set'
						}, {
							label: '财务管理',
							name: 'caiwu_list'
						}, {
							label: '付款',
							name: 'pay'
						}]
					}, {
						label: '会员',
						name: 'member',
						children: [{
							label: '会员列表',
							name: 'member_list'
						}]
					}, {
						label: '设置',
						name: 'cset',
						children: [{
							label: '广告管理',
							name: 'ad_list'
						}, {
							label: '文章管理',
							name: 'article_list'
						}, {
							label: '站点管理',
							name: 'site_set'
						}, {
							label: '管理组',
							name: 'group_list'
						}]
					}]
				}]


			};
		},
		components: {

		},
		methods: {
			//提交
			sub() { 
				const arr = {}
				arr['name']=this.group_name
				arr['res']=this.$refs.tree.getCheckedKeys() 
				var that = this;
				this.http.post('/admin/add_group', arr)
					.then((res) => {
						this.$message({
							showClose: true,
							message: '新增成功',
							type: 'success'
						}); 
						this.$emit('trigger')
					});
			},
			//修改
			onEdit(){
				const arr = {}
				arr['id']=this.eid
				arr['name']=this.group_name
				arr['res']=this.$refs.tree.getCheckedKeys() 
				var that = this;
				this.http.post('/admin/edit_group', arr)
					.then((res) => {
						this.$message({
							showClose: true,
							message: '修改成功',
							type: 'success'
						}); 
						this.$emit('trigger')
					});
			},
			get_group_one(id){
				this.http.post('/admin/group/'+id)
					.then((res) => { 
						if(res.data.name && res.data.oauth){
							this.group_name=res.data.name
							this.checked=res.data.oauth
						}
					});
			}
		},
		mounted() {
			if (this.eid > 0) { //大于0为编辑模式
				this.get_group_one(this.eid);
			}
		}
	}
</script>

<style lang="less">
	#create {
		#map {
			width: 80%;
			height: 400px;
			margin-top: 10px;
		}

		.el-form-item__content {
			line-height: 25px;
			;
		}

		.release {
			text-align: left;
		}

		.release-buy {
			font-weight: bold;
			line-height: 50px;
		}

		table.gridtable {
			font-family: verdana, arial, sans-serif;
			font-size: 11px;
			color: #333333;
			border-width: 1px;
			border-color: #ccc;
			border-collapse: collapse;
		}

		table.gridtable th {
			border-width: 1px;
			padding: 8px;
			border-style: solid;
			border-color: #ccc;
			background-color: #F2F2F2;
		}

		table.gridtable td {
			border-width: 1px;
			padding: 8px;
			border-style: solid;
			border-color: #ccc;
			background-color: #ffffff;
		}

		.upload-demo {
			width: 50% !important;
		}

		.img_array_ul {
			width: 80%;
		}

		.img_array_ul li {
			display: inline-block;
			width: 160px;
			text-align: center;
		}

		.img_array_ul li input {
			width: 80px;
			height: 28px;
			border: 1px solid #cdcdcd;
			text-align: center;
		}

		.img_array_ul li img {
			display: block;
			margin: auto;
			width: 100px;
			height: 130px;
		}
	}
</style>
