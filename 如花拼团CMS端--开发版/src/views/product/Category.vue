<template>
	<div id="category">
		<transition appear appear-active-class="animated fadeInLeft">
			<div class="category">
				<!-- 弹窗--新增分类 -->
				<AddCategory @up_parent="up_list" :list="category_top"></AddCategory>

				<!-- 弹窗--修改分类 -->
				<el-dialog title="" :visible.sync="editbox" width="35%" center>
					<el-form :model="editform">
						<el-form-item label="商品分类名称" :label-width="formLabelWidth" style='width: 80%'>
							<el-input v-model="editform.category_name" auto-complete="off"></el-input>
						</el-form-item>
						<el-form-item label="商品分类简称" :label-width="formLabelWidth" style='width: 80%'>
							<el-input v-model="editform.short_name" auto-complete="off"></el-input>
						</el-form-item>
						<el-form-item label="上级分类" :label-width="formLabelWidth">
							<el-select v-model="editform.pid" placeholder="请选择分类">
								<el-option label="顶级分类" value="0"></el-option>
								<el-option v-for="item in category_top" :value="item.category_id" :label="item.category_name"></el-option>
							</el-select>
						</el-form-item>
						<el-upload class="upload-demo" :action="upfile_url" :data="upfile_data" :on-success="up_ok" :headers="upfile_head">
							<el-button size="small" type="primary">点击上传</el-button>
						</el-upload>
					</el-form>
					<div slot="footer" class="dialog-footer" style='text-align: center'>
						<el-button @click="editbox = false">取 消</el-button>
						<el-button type="primary" @click="onSubmit(editindex)">确 定</el-button>
					</div>
				</el-dialog>


				<template>
					<el-table :data="category" border style="width: 100%">
						<el-table-column prop="" label="排序" width="70">
							<template slot-scope="scope">
								<el-input v-model="input" placeholder="" style='font-size: 12px'></el-input>
							</template>

						</el-table-column>
						<el-table-column type="index" label="序号" width="80">
						</el-table-column>
						<el-table-column prop="category_name" label="分类名字" width="280">
							<template slot-scope="scope">
								<span v-if="scope.row.line">&emsp;&emsp;|——</span>{{scope.row.category_name}}
							</template>
						</el-table-column>
						<el-table-column prop="short_name" label="商品分类简称" width="180">
						</el-table-column>
						<el-table-column prop="imgs" label="缩略图" width="150">
							<template slot-scope="scope">
								<img :src="scope.row.imgs" width="40" height="40" />
							</template>
						</el-table-column>
						<el-table-column prop="pid" label="Pid" width="150">
						</el-table-column>
						<el-table-column prop="is_visible" label="是否显示" width="150">
							<template slot-scope="scope">
								<el-switch @change="onswitch(scope.row.category_id)" v-model="scope.row.is_visible" active-color="#409EFF"
								 inactive-color="#DCDFE6">
								</el-switch>
							</template>
						</el-table-column>
						<el-table-column prop="level" label="操作">
							<template slot-scope="scope">
								<el-button type="success" size="small" @click="onedit(scope.$index)">修改</el-button>
								<el-button type="danger" size="small" @click="del(scope.row.category_id,scope.$index)">删除</el-button>

							</template>
						</el-table-column>
					</el-table>
				</template>

			</div>
		</transition>
	</div>
</template>

<script>
	import {
		Loading
	} from 'element-ui';
	import AddCategory from './components/AddCategory.vue' 
  import {Api_url} from '@/common/config.js'  

	export default {
		name: 'Category',
		components: {
			AddCategory,
		},
		data() {
			return {
				input: '',
				category: [],
				category_top: [],
				dialogTableVisible: false,
				editbox: false, //修改的box
				editform: {
					category_name: '',
					short_name: '',
					pid: '',
					category_pic: ''
				},
				formLabelWidth: '120px',
				editindex: 0,
				upfile_url: Api_url+'/admin/upload/img',
				upfile_data: {
					use: 'category'
				},
				upfile_head: {
					token: localStorage.getItem("token")
				}
			};
		},
		methods: {
			getCategory() {
				var that = this;
// 				let loadingInstance = Loading.service({
// 					fullscreen: true
// 				}); //显示加载
				var arr = [];
				//获取所有分类	
				this.http.get('/admin/get_category_all')
					.then((res) => {
						// loadingInstance.close(); //关闭加载 
						console.log(that.category);
						for (var i = 0; i < res.data.length; i++) {
							if (res.data[i].level == 1) {
								arr.push(res.data[i]);
							}
							if (res.data[i].level == 2) {
								res.data[i].line = true;
							} else {
								res.data[i].line = false;
							}
						}
						that.category = res.data;
						that.category_top = arr;
					});
			},

			//删除分类
			del(id, index) {
				var that = this;
				this.$confirm('是否删除?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					this.http.put('/admin/del_category', {
						id: id
					}).then((res) => {
						that.$message({
							showClose: true,
							message: '删除成功',
							type: 'success'
						});
						that.category.splice(index, 1);
						return false;
					})
				})
			},
			//修改分类
			onedit(index) {
				this.editform = this.category[index];
				this.editindex = index;
				this.editbox = true;
			},
			//新增分类成功后
			up_list() {
				this.getCategory();
			},
			//更新分类
			onSubmit(index) {
				var that = this;
				this.http.put('/admin/update_category', {
						form: that.editform
					})
					.then((res) => {
						console.log(res.data);
						that.editbox = false;
						this.category.splice(index, 1, res.data);
					});
			},
			//是否隐藏
			onswitch(id) {
				var that = this;
				this.http.put('/admin/update', {
						id: id,
						db: 'category',
						field: 'is_visible'
					})
					.then((res) => {
						console.log(res);
					});
			},
			up_ok(res) {
				if (res.code == 201) {
					this.editform.category_pic = res.id;
				}
			},

		},
		mounted() { 
			this.getCategory(); //获取分类  
		}
	}
</script>

<style lang="less" scoped="">
	#category {
		.category {
			line-height: 30px;
			text-align: left;
		}

		.btn {
			margin-bottom: 6px;
		}
	}
</style>
