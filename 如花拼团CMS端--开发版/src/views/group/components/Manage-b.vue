<template>
	<div class="manage">

		<div v-if="addShow" class="add-category ">

			<div class="order-back">
				<el-button type="primary" size="small" @click="back">返回</el-button>
			</div>
			<manage-power @trigger="back" :eid="eid"> </manage-power>
		</div>
		<div class="list" v-if="!addShow">

			<div class="list-head">
				<el-row>
					<el-button @click="handleEdit()" type="primary" size='small'>添加管理组</el-button>
				</el-row>
			</div>
			<template>
				<el-table style="width: 100%" :data="list">
					<el-table-column type="index" width="50"></el-table-column>
					<el-table-column prop="name" label="管理组名称" width="280"></el-table-column>
					<el-table-column prop="create_time" label="创建时间" width="240"></el-table-column> 
					<el-table-column prop="operation" label="操作">
						<template slot-scope="scope" v-if="scope.row.id!=1"> 
							<el-button type="success" size="small" @click="on_edit(scope.row.id)">编辑</el-button> 
							<el-button style="margin-left: 10px" type="danger" size="small"
							  @click="del(scope.row.id,scope.$index)">删除</el-button>


						</template>
					</el-table-column>
				</el-table>
			</template>
		</div>
	</div>
</template>

<script>
	import ManagePower from './add_group.vue'
	export default {
		name: 'Manage-b',
		data() {
			return {
				addShow: false, //设置要显示的页面部分默认为false，隐藏 
				checkdDistributor: null,
				aid: 0,
				eid:0,
				list: []
			}
		},
		components: {
			ManagePower,
		},
		methods: {

			handleEdit(row) {
				this.addShow = true; // addshow为要显示的页面  
				//this.aid = row;
			},
			back() {
				this.order_id = 0;
				this.eid=0
				this.addShow = false;
				this._getall()
			},
      del(id,index){ 
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('admin/del_group',{id:id}).then(res => {
						this.$message({
						message: '删除成功',
						type: 'success'
						});
						this.list.splice(index, 1);
					}) 
				})
			},
			on_edit(id){ 
				this.addShow = true;
				this.eid=id
			},
			_getall(){
				this.http.post('/admin/get_group_all')
					.then((res) => { 
						this.list = res.data
					});
			}
		},
		mounted() {
			this._getall()
		}
	}
</script>

<style lang="less" scoped="">
	.manage {
		line-height: 30px;
		text-align: left;
	}

	.list-head {
		padding-bottom: 10px
	}
</style>
