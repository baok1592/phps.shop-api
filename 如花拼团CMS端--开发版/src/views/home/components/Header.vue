<template>
	<div class="header">


		<div class="head-img">
			<el-dropdown trigger="click" @command="head">
				<span class="el-dropdown-link head-img-click">
					<img src="../../../../public/image/bbbb.jpg"><i class="el-icon-arrow-down el-icon--right"></i>
				</span>
				<el-dropdown-menu slot="dropdown">
					<el-dropdown-item command="edit">修改密码</el-dropdown-item>
					<el-dropdown-item command="lout">退出</el-dropdown-item>
				</el-dropdown-menu>
			</el-dropdown>
		</div>
		<div class="head-x">
			<el-dropdown>
				<span class="el-dropdown-link">
					小程序
				</span>
				<el-dropdown-menu slot="dropdown">
					<el-dropdown-item><img src="../../../../public/image/gh344.jpg" style='width: 100px;height: 100px'></el-dropdown-item>
				</el-dropdown-menu>
			</el-dropdown>
		</div>
	<!-- 	<div class="head-x">
			<el-dropdown>
				<span class="el-dropdown-link">
					微信
				</span>
				<el-dropdown-menu slot="dropdown">
					<el-dropdown-item><img src="../../../../public/image/qrcode.jpg" style='width: 100px;height: 100px'></el-dropdown-item>
				</el-dropdown-menu>
			</el-dropdown>
		</div> -->

		<div class="list-head">
			<el-row>
				<el-dialog title="" :visible.sync="dialogFormVisible" width="35%" center>
					<el-form :model="form">
						<el-form-item label="原密码" :label-width="formLabelWidth">
							<el-input type="password" v-model="form.old_password" auto-complete="off"></el-input>
						</el-form-item>
						<el-form-item label="新密码" :label-width="formLabelWidth">
							<el-input type="password" v-model="form.password" auto-complete="off"></el-input>
						</el-form-item>
						<el-form-item label="再次输入密码" :label-width="formLabelWidth">
							<el-input type="password" v-model="form.password2" auto-complete="off" @keyup.enter.native="edit"></el-input>
						</el-form-item>

					</el-form>
					<div slot="footer" class="dialog-footer">
						<el-button type="primary" @click="edit()">确 定</el-button>
					</div>
				</el-dialog>
			</el-row>
		</div>
	</div>
</template>

<script>
	export default {
		name: 'Header',
		data() {
			return {
				dialogFormVisible: false,
				form: {
					old_password: '',
					password: '',
					password2: '',
				},
				formLabelWidth: '120px',
			}
		},
		methods: {
			head(command) {
				if (command == 'lout') {
					this.$confirm('确定退出?', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						localStorage.clear();
						location.href = './#/login';
					});
				}
				if (command == 'edit') {
					this.dialogFormVisible = true
				}
			},
			edit() {
				var that = this;
				if (this.form.password != this.form.password2) {
					that.$message({
						showClose: true,
						message: '两次新密码不一致',
						type: 'error'
					});
					return false;
				}
				//箭头函数()=>{ }
				this.http.put('/admin/edit_pwd', this.form).then((res) => { 
						that.$message({
							showClose: true,
							message: '修改成功',
							type: 'success'
						});
						//并不高效 清空form的办法
						for (var x in this.form) {
							this.form[x] = ""
						}
						that.dialogFormVisible = false; 
				});
			}
		}
	}
</script>

<style lang="less">
	.header {
		text-align: right;
		display: flex;
		flex-direction: row-reverse;

		.head-img img {
			height: 40px;
			width: 40px;
			padding-top: 10px
		}

		.head-x {
			padding-right: 35px;
			line-height: 60px;
		}

		.head-img-click {
			cursor: pointer;
		}
	}
</style>
