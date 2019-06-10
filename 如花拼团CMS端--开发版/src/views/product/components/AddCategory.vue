<template>
	<div class="btn">
		<el-row>
			<el-button type="primary" class="btn" @click="addbox = true">添加商品分类</el-button>
		</el-row>
		<el-dialog title="" :visible.sync="addbox" width="35%" center>
			<el-form :model="addform">
				<el-form-item label="商品分类名称" :label-width="formLabelWidth" style='width: 80%'>
					<el-input v-model="addform.category_name" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="商品分类简称" :label-width="formLabelWidth" style='width: 80%'>
					<el-input v-model="addform.short_name" auto-complete="off"></el-input>
				</el-form-item>
				<el-form-item label="上级分类" :label-width="formLabelWidth">
					<el-select v-model="addform.pid" placeholder="请选择分类">
						<el-option label="顶级分类" value="0"></el-option>
						<el-option v-for="item in list" :value="item.category_id" :label="item.category_name"></el-option>
					</el-select>
				</el-form-item>
				<el-upload class="upload-demo" :action="upfile_url" :data="upfile_data" :on-success="up_ok" :limit=1 :file-list="upfile_list"
				 :headers="upfile_head">
					<el-button size="small" type="primary">点击上传</el-button>
				</el-upload>
			</el-form>
			<div slot="footer" class="dialog-footer" style='text-align: center'>
				<el-button @click="addbox = false">取 消</el-button>
				<el-button type="primary" @click="onSubmit">确 定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>	
import {Api_url} from '@/common/config.js'  
	export default {
		name: 'Category',
		props: ['list'],
		data() {
			return {
				addbox: false,
				addform: {
					category_name: '',
					short_name: '',
					pid: '',
					category_pic: ''
				},
				formLabelWidth: '120px',
				upfile_url: Api_url+'/admin/upload/img',
				upfile_data: {
					use: 'category'
				},
				upfile_head: {
					token: localStorage.getItem("token")
				},
				upfile_list: [], //上传文件列表
			};
		},
		methods: {
			//新增分类
			onSubmit() {
				var that = this;
				this.http.post('/admin/add_category', {
						form: that.addform
					}).then((res) => {
						that.$message({
							showClose: true,
							message: '新增成功',
							type: 'success'
						});
						that.addbox = false;
						for (var x in that.addform) {
							that.addform[x] = ""
						};
						that.upfile_list = [];
						that.$emit("up_parent");
					});
			},
			up_ok(res) {
				if (res.code == 201) {
					this.addform.category_pic = res.id;
				}
			},
		},
	}
</script>

<style lang="less" scoped="">
	.category {
		line-height: 30px;
		text-align: left;
	}

	.btn {
		margin-bottom: 6px;
	}
</style>
