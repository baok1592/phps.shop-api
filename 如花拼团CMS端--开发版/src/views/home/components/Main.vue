<template>
	<div id="main">
		<el-row>
			<el-col :span="24">
				<div class="grid-content bg-purple-dark">
					<ul class="mall">
						<li>
							<div class="mall-01"><img src="../../../../public/image/0.png"></div>
							<div class="mall-02">
								<p class="mall-02-01">{{info.user_number}}</p>
								<p>用户人数（个）</p>
							</div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="mall-01"><img src="../../../../public/image/0.png"></div>
							<div class="mall-02">
								<p class="mall-02-01">{{info.goods_number}}</p>
								<p>商品发布（个）</p>
							</div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="mall-01"><img src="../../../../public/image/0.png"></div>
							<div class="mall-02">
								<p class="mall-02-01">{{info.order_number}}</p>
								<p>订单总数（笔）</p>
							</div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="mall-01"><img src="../../../../public/image/0.png"></div>
							<div class="mall-02">
								<p class="mall-02-01">{{info.drive_number}}</p>
								<p>已完成交易（笔）</p>
							</div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="mall-01"><img src="../../../../public/image/0.png"></div>
							<div class="mall-02">
								<p class="mall-02-01">{{info.money_total}}</p>
								<p>总销售金额（元）</p>
							</div>
							<div class="clear"></div>
						</li>
						
							<li>
								<div class="mall-01"><img src="../../../../public/image/0.png"></div>
								<div class="mall-02">
									<p class="mall-02-01"></p>
									<p>今日订单总金额（元）</p>
								</div>
								<div class="clear"></div>
							</li>
					</ul>
					<div class="clear"></div>
				</div>
			</el-col>
		</el-row>
		<el-row :gutter="20">
			<el-col :span="15">
				<div class="grid-content bg-purple">
					<div class="main-cue"><i class="i-circular"></i> 交易提示<span>您需要立即处理的交易订单</span></div>
					<ul class="main-cue-ul">
						<li>
							{{info.pay_number}}
							<p>已销售</p>
						</li> 
						<li>
							{{info.drive_number}}
							<p>已验证</p>
						</li>
						<li>
							{{info.tui_number}}
							<p>申请退款</p>
						</li>
						<li>
							{{info.shop_number}}
							<p>入住商家</p>
						</li>
						<li>
							{{info.user_number}}
							<p>用户</p>
						</li> 
					</ul>
				</div>
			</el-col>
			<el-col :span="9">
				<div class="grid-content bg-purple">
					<div class="main-cue"><i class="i-circular"></i> 销售情况统计<span>按周期统计商家店铺的订单量和订单金额</span></div>
					<div id="tongji">

						<div class="main-count">
							<div class="main-count-l ">昨日销量</div>
							<div class="main-count-r ">
								<div class="main-count-r-01">订单了（件）3</div>
								<div class="main-count-r-02">订单金额（元）1 </div>
							</div>
							<div class="clear"></div>
						</div>
						<div class="H10"></div>
						<div class="main-count">
							<div class="main-count-l ">昨日销量</div>
							<div class="main-count-r ">
								<div class="main-count-r-01">订单了（件）3</div>
								<div class="main-count-r-02">订单金额（元）1 </div>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>

			</el-col>
		</el-row>
		<el-row :gutter="20">
			<el-col :span="15">
				<div class="grid-content bg-purple">
				</div>
			</el-col>
			<el-col :span="9">
				<div class="grid-content bg-purple">
					<div class="main-cue"><i class="i-circular"></i> 单品销售排名<span>按周期统计商家店铺的订单量和订单金额</span></div>
					<div id="tongji">
						<template>
							<el-table :data="tableData" style="width: 100%">
								<el-table-column prop="date" label="排行" width="50">
								</el-table-column>
								<el-table-column prop="name" label="商品信息">
								</el-table-column>
								<el-table-column prop="address" label="销量" width="50">
								</el-table-column>
							</el-table>
						</template>

					</div>

				</div>
			</el-col>
		</el-row>
	</div>
</template>

<script>
	export default {
		name: 'Main',
		data() {
			return {
				info:"",
				tableData: [{
					date: '2',
					name: 'xxx',
					address: '2'
				}, {
					date: '4',
					name: 'xx',
					address: '3'
				}, {
					date: '8',
					name: 'xx',
					address: '5'
				}, {
					date: '6',
					name: 'xx',
					address: '1'
				}]
			}
		},
		methods:{
			get_list() {
				var that = this;
				this.http.post("/admin/main_tj_data").then((res) => {
					that.info = res.data;
				})
			},
		},
		mounted(){
			//获取统计数据
			//this.get_list()
		}
	}
</script>

<style lang="less">
	#main {
		.el-row {
			margin-bottom: 20px;

			&:last-child {
				margin-bottom: 0;
			}
		}

		.el-col {
			border-radius: 4px;
		}

		.bg-purple-dark {
			background: #ffffff;
		}

		.bg-purple {
			background: #ffffff;
		}

		.grid-content {
			border-radius: 4px;
			min-height: 36px;
			border: 1px solid #e0e0e0;
		}

		.row-bg {
			padding: 10px 0;
			background-color: #f9fafc;
		}

		.H10 {
			height: 10px;
			background-color: #ffffff;
		}

		.clear {
			clear: both;
		}

		.mall {
			padding: 0px;
			margin: 0px;
			height: 100px;
		}

		.mall li {
			line-height: 20px;
			text-align: left;
			display: inline-block;
			width: 16%;
			border-right: 1px solid #f0f0f0;
			padding: 5px 0px 5px 8px;
			box-sizing: border-box
		}

		.mall li img {
			width: 52px;
			height: 52px;
			padding-right: 5px
		}

		.mall-01 {
			float: left;
		}

		.mall-02 {
			float: left;
			color: #808080;
			font-size: 12px;
			line-height: 27px;
		}

		.mall-02-01 {
			color: #000000;
			font-size: 16px;
		}

		.main-cue {
			height: 45px;
			text-align: left;
			line-height: 45px;
			padding-left: 8px;
			font-size: 14px;
		}

		.main-cue span {
			color: #808080;
			font-size: 12px;
			padding-left: 5px
		}

		.i-circular {
			display: inline-block;
			background: #126AE4;
			border-radius: 50%;
			width: 8px;
			height: 8px;
			margin: -1px 5px 0 0;
			vertical-align: middle;
		}

		.main-cue-ul {
			height: 110px;
		}

		.main-cue-ul li {
			display: inline-block;
			width: 14%;
			text-align: center;
			line-height: 28px;
			color: blue;
		}

		.main-cue-ul li p {
			color: #808080
		}

		#tongji {
			padding: 5px 10px 10px 10px;
			line-height: 30px;
			text-align: left;
		}

		.main-count {
			width: 100%;
			height: 80px;
			margin: 0px;
			font-size: 14px;
		}

		.main-count-l {
			width: 30%;
			text-align: center;
			line-height: 80px;
			height: 80px;
			display: inline-block;
			background-color: #f0f0f0;
			float: left;
		}

		.main-count-r {
			width: 70%;
			line-height: 40px;
			height: 78px;
			display: inline-block;
			text-align: left;
			float: left;
			box-sizing: border-box;
		}

		.main-count-r-01 {
			border: 1px solid #f0f0f0;
			padding-left: 20px;
			height: 38px
		}

		.main-count-r-02 {
			border-bottom: 1px solid #f0f0f0;
			padding-left: 20px;
			border-right: 1px solid #f0f0f0;
			height: 39px;
		}
	}
</style>
