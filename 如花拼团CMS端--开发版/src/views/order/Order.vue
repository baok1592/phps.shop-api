<template>
	<div v-if="auth">
		<transition appear appear-active-class="animated fadeInLeft">
			<div class="order">

				<div v-if="addShow">

					<div class="order-back">
						<el-button type="primary" size="small" @click="back">返回</el-button>
					</div>
					<order-details :order_id='this.order_id'></order-details>
				</div>

				<template v-if="!addShow">
					<div class="list-head">

						<div class="liat-head-02">
							订单号：<el-input placeholder="请输入内容" style='width: 70%' size='small' v-model="value"></el-input>
						</div>
						<div class="liat-head-03">
							<el-row>
								<el-button type="primary" size='small' @click='serach'>搜索</el-button>
								<el-button type="success" size='small' @click='all'>刷新</el-button>
							</el-row>
						</div>
					</div>
					<el-table :data="order" border style="width: 100%">
						<el-table-column type="index" label="序号" width="50"></el-table-column>
						<el-table-column prop="order_num" label="订单号" width="180"></el-table-column>
						<el-table-column label="商品名称" width="280">
							<template slot-scope="scope">
								<div v-for="item,key of scope.row.ordergoods">
									{{item.goods_name | ellipsis}}
								</div>
							</template>
						</el-table-column>
						<el-table-column prop="order_money" label="订单价格" width="100"></el-table-column>
						<el-table-column label="类型" width="160">
							<template slot-scope="scope">
								<p v-if="scope.row.type == 1">拼团商品</p>
								<p v-else>普通商品</p>
							</template>
						</el-table-column>
						<el-table-column prop="users.nickname" label="用户" width="160">
						</el-table-column> 
						<el-table-column label="支付状态" width="100">
							<template slot-scope="scope">
								<p v-if="scope.row.pay_status == 1">已支付</p>
								<p v-else style="color:Red;">未支付</p>
							</template>
						</el-table-column>
						<el-table-column label="货物状态" width="160">
							<template slot-scope="scope"> 
								<p style="color:#909399" v-if="scope.row.drive_status == 1 && scope.row.receive_status == 1">
									已收货
								</p>
								<p style="color:#67C23A" v-else-if="scope.row.drive_status == 1 && scope.row.receive_status == 0">
									已发货
								</p>
								<p style="color:#E6A23C" v-else >
									未发货
								</p> 
							</template>
						</el-table-column>
						<el-table-column prop="operation" label="操作">
							<template slot-scope="scope">
								<el-button @click="show_order(scope.row.order_id)" type="primary" size="small">查看</el-button>
								<el-button style="margin-left: 10px" type="danger" size="small" slot="reference" @click="del(scope.row.order_id,scope.$index)">删除</el-button>
							</template>
						</el-table-column>
					</el-table>
					<el-pagination style='padding-top: 60px;text-align: center;' background layout="prev, pager, next" :total="page.total"
					 :page-size="page.per_page" @current-change="handleCurrentChange">
					</el-pagination>
				</template>

			</div>
		</transition>
	</div>

</template>

<script>
	import OrderDetails from './Details.vue'
	import {
		Loading
	} from 'element-ui';
	export default {
		name: 'Order',
		filters: {
			ellipsis(value) {
				if (!value) return ''
				if (value.length > 18) {
					return value.slice(0, 18) + '...'
				}
				return value
			}
		},
		data() {
			return {
				value: '',
				visible2: false,
				order: [],
				addShow: false, //设置要显示的页面部分默认为false，隐藏 
				checkdDistributor: null,
				order_id: 0,
				page: [], 
				auth:false
			}
		},
		components: {
			OrderDetails,
		},
		methods: {
			serach() {
				this.post_order(1, this.value);

			},
			all() {
				let loadingInstance = Loading.service();
				this.post_order();
				this.value = '';
				loadingInstance.close();
			},
			handleCurrentChange(val) {
				this.post_order(val);
			},
			handleClick(row) {
				console.log(row);
			},
			post_order(index = 1, keywords = '') {
				var that = this;
				this.http.post("/admin/get_order_all", {
					page: index,
					size: 8,
					keywords: keywords
				}).then((res) => {
					that.order = res.data.data; //收藏返回的是商品和店铺
					that.page = res.data;
				})
			},
			show_order(row) {
				this.addShow = true; // addshow为要显示的页面  
				this.order_id = row;
			},
			back() {
				this.order_id = 0;
				this.addShow = false;
			},
			//删除订单
			del(id, index) {
				var that = this;
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('/admin/del_order', {
							id: id
						})
						.then((res) => {
							if (res.data == 1) {
								this.$message({
									showClose: true,
									message: '删除成功',
									type: 'success'
								});
								this.order.splice(index, 1);
								return false;
							} else if (res.response.status == 400) {
								this.$alert(res.response.data.msg, '');
								return false;
							} else {
								this.$message({
									showClose: true,
									message: '删除失败',
									type: 'error'
								});
								return false;
							}
						});
				})
			}, 
			check_auth(name){				
				const auth=localStorage.getItem("oauth");
				if(auth.indexOf(name)<0){
					this.$message({
					  message: '无权限',
					  type: 'none'
					}); 
				}else{
					this.auth=true
				}
			}
		},
		//vue生命函数
		mounted() {
			this.check_auth('order_list')
			this.post_order();
		}

	}
</script>

<style lang="less">
	.order {
		line-height: 30px;
		text-align: left;
	}

	.order-back {
		margin-bottom: 10px;
	}

	.list-head {
		padding-bottom: 10px;
		display: flex;
	}

	.liat-head-02 {
		font-size: 14px;
		padding-left: 10px
	}
</style>
