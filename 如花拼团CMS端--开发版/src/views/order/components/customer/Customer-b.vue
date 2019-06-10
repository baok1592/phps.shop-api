<template>
	<div class="">
		<div v-if="addShow" class="add-category ">

			<div class="order-back">
				<el-button type="primary" size="small" @click="back">返回</el-button>
			</div>
			<order-details :order_id='this.order_id'></order-details>
		</div>

		<template v-if="!addShow">
			<el-table :data="list" border style="width: 100%">
				<el-table-column type="index" width="50"> </el-table-column>
				<el-table-column prop="order_num" label="订单号" width="200"></el-table-column>
				<el-table-column prop="because" label="退款原因" width="160"></el-table-column>
				<el-table-column prop="message" label="客户留言" width="220"> </el-table-column>
				<el-table-column prop="ip" label="IP" width="180"></el-table-column>
				<el-table-column prop="money" label="退款金额" width="180"></el-table-column>
				<el-table-column prop="operation" label="状态">
					<template slot-scope="scope">
						<el-button type="primary" size="small" v-if="scope.row.status==0" @click="sub(scope.row.order_id,scope.$index)">退款</el-button>
						<el-button style="margin-left: 10px" type="danger" size="small" slot="reference" v-if="scope.row.status==0"
						 @click="bohui(scope.row.id,scope.$index)">驳回申请</el-button>
						<span v-if="scope.row.status==1">已退款-退款单号：{{scope.row.wx_id}}</span>
						<span v-if="scope.row.status==-1">已驳回-驳回原因：{{scope.row.remark}}</span>
					</template>
				</el-table-column>
			</el-table>
		</template>
	</div>
</template>

<script>
	import OrderDetails from '../../Details.vue'
	export default {
		name: 'Customer-b',
		data() {
			return {
				visible2: false,
				list: [],
				addShow: false, //设置要显示的页面部分默认为false，隐藏 
				checkdDistributor: null,
				order_id: 0
			}
		},
		components: {
			OrderDetails,
		},
		methods: {
			get_list() {
				var that = this;
				this.http.post("/admin/get_tui_all").then((res) => {
					that.list = res.data;
				})
			},
			//订单
			sub(id, index) {
				var that = this;
				this.$confirm('确定退款?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.post('/admin/tui_money', {
						id: id
					}).then(res => {
						that.$message({
							showClose: true,
							message: '操作成功',
							type: 'success'
						});
						this.get_list();
					});
				})
			},
			//驳回订单
			bohui(id, index) {
				var that = this;
				this.$prompt('驳回原因', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消'
					}).then(({ value }) => {
								this.http.post('/admin/tui_bohui', {
									id: id,
									msg: value
								}).then(res => {
									console.log(res)
									this.get_list();
								})
							})
						}
					},
					//vue生命函数
					mounted() {
						this.get_list();
					}



			}
</script>

<style lang="less" scoped="">
	.order-back {
		margin-bottom: 10px;
	}
</style>
