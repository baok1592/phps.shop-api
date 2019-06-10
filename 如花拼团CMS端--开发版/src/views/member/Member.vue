<template>
	<div  v-if="auth">
		<transition appear appear-active-class="animated fadeInLeft">
			<div class="member">
				<div v-if="addShow" class="add-category ">
					<div class="order-back">
						<el-button type="primary" size="small" @click="back">返回</el-button>
					</div>
					<member-message :order_id='aid'></member-message>
				</div>
				<template v-if="!addShow">
					<div class="list-head">

						<div class="liat-head-02">
							昵称：<el-input placeholder="请输入内容" style='width: 70%' size='small' v-model="value"></el-input>
						</div>
						<div class="liat-head-03">
							<el-row>
								<el-button type="primary" size='small' @click='serach'>搜索</el-button>
								<el-button type="success" size='small' @click='all'>所有</el-button>
							</el-row>
						</div>
					</div>
					<el-table :data="member" border style="width: 100%">
						<el-table-column prop="id" label="ID" width="80"></el-table-column>
						<el-table-column prop="nickname" label="昵称" width="120"></el-table-column>
						<!-- <el-table-column prop="mobile" label="电话号码" width="120"></el-table-column> -->
						<el-table-column prop="openid" label="openid" width="280"></el-table-column>
						<el-table-column prop="create_time" label="创建时间"></el-table-column>

						<!-- <el-table-column prop="is_visible" label="是否禁用" width="120">
							<template slot-scope="scope">
								<el-switch @change="onswitch(scope.row.id)" v-model="scope.row.is_visible" active-color="#409EFF"
								 inactive-color="#DCDFE6">
								</el-switch>
							</template>
						</el-table-column> -->
						<!-- 			<el-table-column  prop="operation"  label="操作" >
						<template slot-scope="scope">
							<el-button @click="handleEdit(scope.row.id)" type="primary" size="small">查看</el-button>
							<el-button type="success" size="small">编辑</el-button>							
							<el-button style="margin-left: 10px" type="danger" size="small" slot="reference">删除</el-button>	
						</template>
					</el-table-column> -->
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
	import MemberMessage from './Message.vue'

	export default {
		name: 'Member',
		data() {
			return {
				value: '',
				page: [],
				visible2: false,
				member: [],
				addShow: false, //设置要显示的页面部分默认为false，隐藏 
				checkdDistributor: null,
				aid: 0,
				auth:false   
			}
		},
		components: {
			MemberMessage,
		},
		methods: {
			serach() {
				this.post_member(1, this.value);

			},
			all() {
				this.post_member();
				this.value = '';
			},
			handleCurrentChange(val) {
				this.post_member(val);
			},
			post_member(index = 1, keywords = '') {
				var that = this;
				this.http.post("/admin/get_user_all", {
					page: index,
					size: 8,
					keywords: keywords
				}).then((res) => {
					that.member = res.data.data; //收藏返回的是商品和店铺
					that.page = res.data;
				})
			},
			handleEdit(row) {
				this.addShow = true; // addshow为要显示的页面  
				this.aid = row;
			},
			back() {
				this.order_id = 0;
				this.addShow = false;
			},
			//是否禁用
			onswitch(id) {
				var that = this;
				this.http.put('/admin/update', {
						id: id,
						db: "user",
						field: "is_visible"
					})
					.then((res) => {
						console.log(res);
					});
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
			this.check_auth('member_list')
			this.post_member();
		}
	}
</script>

<style lang="less" scoped="">
	.member {
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
