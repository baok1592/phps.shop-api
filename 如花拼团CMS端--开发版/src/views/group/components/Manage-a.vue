<template>
	<div class="manage">
		<div class="list">
			<div class="list-head">
				<el-row>
					<el-button type="primary" size='small' @click="add_fun">添加用户</el-button>
					<el-dialog title="" :visible.sync="add" width="420px">
						<el-form :model="form" label-width="100px">
							<el-form-item label="用户名">
								<el-input v-model="form.username" v-if="eid==0" auto-complete="off"></el-input>
								<el-input v-model="form.username" v-else :disabled="true" auto-complete="off"></el-input>
							</el-form-item>
							<el-form-item label="密码" v-if="eid==0">
								<el-input type="password" v-model="form.password" auto-complete="off"></el-input>
							</el-form-item>
							<el-form-item label="所属用户组">
								<el-select v-model="form.gid" placeholder="请选择用户组">
									<el-option v-for="item in group_list" :key="item.id" :label="item.name" :value="item.id">
									</el-option>
								</el-select>
							</el-form-item>
							<el-form-item label="描述">
								<el-input v-model="form.description" placeholder="请输入内容">
								</el-input>
							</el-form-item>

						</el-form>
						<div slot="footer" class="dialog-footer">
							<el-button type="primary" v-if="eid<1"  @click="register()">确 定</el-button>							
							<el-button v-else type="success" @click="onEditSub">修改</el-button>
						</div>
					</el-dialog>
				</el-row>
			</div>
			<template>
				<el-table :data="list" border style="width: 100%">
					<el-table-column type="index" label="序号" width="50"></el-table-column>
					<el-table-column prop="username" label="名称" width="180"></el-table-column>
					<el-table-column prop="groups.name" label="管理组" width="180"></el-table-column>
					<el-table-column prop="description" label="备注" width="180"></el-table-column> 
					<el-table-column prop="create_time" label="创建时间" width="180"></el-table-column> 
					<el-table-column prop="state" label="是否禁用" width="180">
						<template slot-scope="scope">
							<el-switch @change="onswitch(scope.row.id)" v-model="scope.row.state" active-color="#409EFF" inactive-color="#DCDFE6">
							</el-switch>
						</template>
					</el-table-column>
					<el-table-column prop="operation" label="操作">
						<template slot-scope="scope">
							
								<el-button type="success" size="small" @click="on_edit(scope.row.id,scope.row.username,scope.row.description,scope.row.group_id)">编辑</el-button> 
							<el-button style="margin-left: 10px" type="danger" size="small" slot="reference" @click="del(scope.row.id,scope.$index)">删除</el-button>
						</template>
					</el-table-column>
				</el-table>
			</template>
		</div>
	</div>
</template>

<script>
	export default {
		name: 'Manage-a',
		data() {
			return {
				add: false,
				form: {
					username: '',
					password: '',
					gid: '',
					edi:0,
					description: '',
				},
				formLabelWidth: '120px',
				list: []
			}
		},
		methods: {
			add_fun(){
				this.add = true
				this._clsForm()
				this.eid=0
			},
			//新增管理员
			register() {
				var that = this;
				this.http.post('/admin/add_admin', that.form)
					.then((res) => { 
							that.$message({
								showClose: true,
								message: '添加成功',
								type: 'success'
							});
							that.add = false;
							that.getUser(); 
							that._clsForm()
					});
			},
			//清空form表单数据
			_clsForm() {
				var that = this;
				for (var x in that.form) {
					that.form[x] = ""
				};
			},
			//获取要修改人员的数据
			on_edit(id,name,dsc,gid){ 
				this.add = true;
				this.eid=id
				this.form.username=name
				this.form.gid=gid
				this.form.description=dsc
			},
			//提交修改
			onEditSub(){
				const that = this;		
				let data={}
				data['id']=this.eid
				data['gid']=this.form.gid
				data['description']=this.form.description 
				this.http.put('/admin/edit_admin', data)
					.then((res) => { 
							that.$message({
								showClose: true,
								message: '操作成功',
								type: 'success'
							});
			        that.getUser();
							that.add = false; 
							that.eid=0
							that._clsForm()
					});
			},
			//获取所有管理员
			getUser() {
				var that = this;
				this.http.post('/admin/get_admin')
					.then((res) => {
						that.list = res.data;
					});
			},
			//删除商品
			del(id, index) {
				var that = this;
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('/admin/del_admin', {
							id: id
						})
						.then((res) => {
							var res_code = res.status.toString(); //返回结果状态码转字符串取第一位数
							if (res_code.charAt(0) == 2) {
								that.$message({
									showClose: true,
									message: '删除成功',
									type: 'success'
								});
								that.list.splice(index, 1);
							} else {
								that.$message({
									showClose: true,
									message: res.data.msg,
									type: 'error'
								});
							}
						});
				})
			},
			//是否禁用
			onswitch(id) {
				var that = this;
				this.http.put('/admin/update', {
						id: id,
						db: 'admins',
						field: 'state'
					})
					.then((res) => {
							that.$message({
							showClose: true,
							message: '操作成功',
							type: 'success'
						});
					});
			},
			_getallgroup() {
				this.http.post('/admin/get_group_all')
					.then((res) => {
						console.log('xx:',res.data)
						this.group_list = res.data
					});
			}
		},
		mounted() {
			this.getUser();
			this._getallgroup()
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
