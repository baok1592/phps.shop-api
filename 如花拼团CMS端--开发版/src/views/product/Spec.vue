<template>
	<div>
		<transition appear appear-active-class="animated fadeInLeft">
	  		<div class="spec">
			    <div class="btn">
			     	<el-row>
			     		<el-button type="warning">批量删除</el-button>
			     		<el-button type="primary" class="btn" @click="dialogFormVisible = true">添加规格</el-button>
			     	</el-row>
					<el-dialog title="" style='width: 80%' :visible.sync="dialogFormVisible">
						<el-form :model="form">
							<el-form-item label="规格名称" :label-width="formLabelWidth" style='width: 80%'>
								<el-input v-model="form.name" auto-complete="off"></el-input>
							</el-form-item>
							<el-form-item label="规格排序" :label-width="formLabelWidth">
								<el-input v-model="form.name" auto-complete="off" style='width: 100px'></el-input>
							</el-form-item>
							<el-form-item label="是否启用" :label-width="formLabelWidth">
								<el-switch v-model="value2"></el-switch>
							</el-form-item>
							<el-form-item label="是否筛选" :label-width="formLabelWidth">
								<el-switch v-model="value2"></el-switch>
							</el-form-item>
							<el-form-item label="规格值" :label-width="formLabelWidth" style='width: 80%'>
								<el-input type="textarea" :rows="5" placeholder="请输入内容" v-model="textarea"></el-input>
							</el-form-item>
							
						</el-form>
						<div slot="footer" class="dialog-footer" style='text-align: center'>
							<el-button @click="dialogFormVisible = false">取 消</el-button>
							<el-button type="primary" @click="dialogFormVisible = false">确 定</el-button>
						</div>
					</el-dialog>
				</div>
				<template>
					<el-table :data="tableData"	border	style="width: 100%">
						<el-table-column	prop="name"	label="规格名称"	width="180">
					    </el-table-column>
					    <el-table-column	prop="name"	label="规格属性"	width="380">
						</el-table-column>
						<el-table-column	prop="address"	label="启用"	width="50">
						</el-table-column>
						<el-table-column	prop="address"	label="是否参与筛选"	width="120">
						</el-table-column>
						<el-table-column	prop="address"	label="排序"	width="50">
						</el-table-column>
						<el-table-column	prop="operation"	label="操作">
							<template slot-scope="scope">
								<el-button @click="handleClick(scope.row)" type="success" size="small">修改</el-button>
								<el-button type="danger" size="small">删除</el-button>
							</template>
					     </el-table-column>
			        </el-table>
			    </template>
			</div>
	  		  
	  	</transition>
	</div>

</template>

<script>
export default {
  name: 'Spec',
 data() {
			return {
				 value1: true,
                 value2: true,
				tableData: [{
					date: '2016-05-02',
					name: '王小虎',
					address: '3'
				}, {
					date: '2016-05-04',
					name: '王小虎',
					address: '2'
				}, {
					date: '2016-05-01',
					name: '王小虎',
					address: '1'
				}, {
					date: '2016-05-03',
					name: '王小虎',
					address: '4'
				}],

				dialogTableVisible: false,
				dialogFormVisible: false,
				form: {
					name: '',
					region: '',
					date1: '',
					date2: '',
					delivery: false,
					type: [],
					resource: '',
					desc: ''
				},
				formLabelWidth: '120px'
			};

		}
	}
</script>

<style lang="less" scoped="">
.spec{line-height: 30px;text-align:left;}
.btn{margin-bottom: 6px;}
</style>