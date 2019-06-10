<template>
	<div id="release">
		<transition appear appear-active-class="animated fadeInLeft">
	  		<div class="release"> 
				<el-form ref="forms" :model="forms" label-width="120px">
					<el-form-item label="商品名称">
						<el-input v-model="forms.goods_name" style='width:60%'></el-input>
					</el-form-item>
					<el-form-item label="商品分类">
						<el-select v-model="forms.category_id" placeholder="请选择活动区域"> 
							<el-option v-for="item in category"  
							:value="item.category_id" :label="item.category_name"></el-option>
						</el-select>
					</el-form-item>
					<el-form-item label="商品促销语">
						<el-input v-model="forms.description" style='width:60%'></el-input>
					</el-form-item>

					<el-row> 
						<el-col :span="6">
							<el-form-item label="基础销量" >
								<el-input v-model="forms.sales" style="width: 100px"></el-input><span> 件</span>
							</el-form-item>
						</el-col>
						<el-col :span="6">
							<el-form-item label="总库存" >
								<el-input v-model="forms.stock" style="width: 100px"></el-input><span> 件</span>
							</el-form-item>
						</el-col>

						<el-col :span="6">
							<el-form-item label="运费" >
								<el-input v-model="forms.shipping_fee" style="width: 100px"></el-input><span> 件</span>
							</el-form-item>
						</el-col>
					</el-row>	
					<el-row>
						<el-col :span="4">
							<el-form-item label="是否包邮">
								<el-switch v-model="forms.postage"></el-switch>
							</el-form-item>
						</el-col>
						<el-col :span="4">
							<el-form-item label="7天退换">
								<el-switch v-model="forms.exchange "></el-switch>
							</el-form-item>
						</el-col>
						<el-col :span="4">
							<el-form-item label="48小时发货">
								<el-switch v-model="forms.send "></el-switch>
							</el-form-item>
						</el-col>
						<el-col :span="4">
							<el-form-item label="假一赔十">
								<el-switch v-model="forms.fidelity"></el-switch>
							</el-form-item>
						</el-col>

					</el-row>
					<el-row>
						<el-col :span="8">
							<el-form-item label="商品主图">
								<el-upload class="upload-demo" 
								  :action="upfile_url"
								  :data="{use:'product'}"
								  :on-success="up_ok"
								  :headers="upfile_head" 
								  :limit=1 
								  :file-list="upfile_list"
								  list-type="picture">
								  <el-button size="small" type="primary">点击上传</el-button> 
								</el-upload>
							</el-form-item> 
						</el-col>
					</el-row>

					<el-row>
						<el-col :span="4.8">
							<el-form-item label="市场价格" >
								<el-input v-model="forms.market_price" style="width: 100px"></el-input><span> 元</span>
							</el-form-item>
						</el-col>
						<el-col :span="4.8">
							<el-form-item label="销售价格" >
								<el-input v-model="forms.price" style="width: 100px"></el-input><span> 元</span>
							</el-form-item>
						</el-col>
						<el-col :span="4.8">
							<el-form-item label="单独购买价格" >
								<el-input v-model="forms.only_price" style="width: 100px"></el-input><span> 元</span>
							</el-form-item>
						</el-col>
						<el-col :span="4.8">
							<el-form-item label="组团人数">
								<el-input v-model="forms.people" style="width: 100px"></el-input><span> 件</span>
							</el-form-item>
						</el-col>
						<el-col :span="4.8">
							<el-form-item label="每人限购" >
								<el-input v-model="forms.max_buy" style="width: 100px"></el-input><span> 件</span>
							</el-form-item>
						</el-col>
					</el-row>
					
					<el-form-item>
						<el-button @click="sku_btn()" type="info" size="small" style="margin-bottom:20px;">添加规格</el-button>
						<div v-show="sku_table">
							<table class="gridtable">
								<tr>
									<th style="width: 200px">商品规格</th>
									<th style="width: 100px">上传图片</th>
									<th>拼团价格</th>
									<th>单独购买价格</th>
									<th>市场价格</th>
									<th>库存</th>
								</tr>
								<tr v-for="(item,index) in forms.sku">
									<td><el-input v-model="item['sku_name']" style="width: 200px"></el-input></td>
									<td>
										<el-upload v-if="item['imgs']" class="upload-demo" 
										  :action="upfile_url"
										  :data="{use:'product',key:index}"
										  :on-success="up_sku_ok"
										  :headers="upfile_head" 
										  :limit=1 		
										  :file-list="[{url:item.imgs.url}]"									  
										  list-type="picture">
										  <el-button size="mini">上传<i class="el-icon-upload el-icon--right"></i></el-button>
									    </el-upload> 
										<el-upload v-else class="upload-demo" 
										  :action="upfile_url"
										  :data="{use:'product',key:index}"
										  :on-success="up_sku_ok"
										  :headers="upfile_head" 
										  :limit=1 		   		
										  :file-list="upfile_list_sku"							  
										  list-type="picture">
										  <el-button size="mini">上传<i class="el-icon-upload el-icon--right"></i></el-button>
									    </el-upload>

									</td>
									<td><el-input v-model="item['price']" style="width: 100px"></el-input></td>
									<td><el-input v-model="item['only_price']" style="width: 100px"></el-input></td>
									<td><el-input v-model="item['market_price']" style="width: 100px"></el-input></td>
									<td><el-input v-model="item['stock']" style="width: 100px"></el-input></td>
								</tr> 
							</table>
							<el-button @click="add_sku_line()" size="small" style="margin-top: 10px">新增一行</el-button>
						</div>	
					</el-form-item>
					<el-form-item label="商品详情" prop="desc">
						<vue-ueditor-wrap v-model="forms.content" :config="myConfig"></vue-ueditor-wrap>
					</el-form-item>

					<el-form-item>
						<el-button type="primary" v-if="sub_btn" @click="onSubmit">立即创建</el-button>
						<el-button v-if="!sub_btn" type="success" @click="onEdit">提交修改</el-button>
						<el-button @click="rest">取消</el-button>
					</el-form-item>
			    </el-form> 

		    </div>
			  		  
	  	</transition>
	</div>
	
</template>

<script>
	import { Loading } from 'element-ui';
	import VueUeditorWrap from 'vue-ueditor-wrap'
	import { Api_url} from '@/common/config'
	export default {
		name: 'Pintuan',
		props:['eid'],
		data() {
			return { 
				myConfig: {
					autoHeightEnabled: false,
					initialFrameHeight: 240,
					initialFrameWidth: '60%',
					serverUrl: Api_url + 'ue_uploads',
					UEDITOR_HOME_URL: '/static/UEditor/',
					toolbars: [
						['justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'bold',
							'forecolor', 'fontsize',  'insertimage'
						]
					]
				},
				category:[],
				forms: {
					goods_name:"",
					category_id:"",
					people:"",
					shipping_fee:"",
					market_price:"",
					price:"",
					only_price:"",
					stock:"",
					max_buy:"",
					people:"",
					img_id:"",
					description:"",
					content:"",
					sales:"",
					sku:[{
						sku_name:"",
						picture:"",
						price:"",
						only_price:"",
						market_price:"",
						stock:"",
					},{
						sku_name:"",
						picture:"",
						price:"",
						only_price:"",
						market_price:"",
						stock:"",
					}],				
				},
				upfile_url: Api_url + '/admin/upload/img',
				upfile_head: {
					token: localStorage.getItem("token")
				},
				upfile_list: [], //上传文件列表 
				upfile_list_sku:[],	//上传文件列表--规格
				sku_table:false,
				sub_btn:true,
			}
		},
		components: {
			VueUeditorWrap
		},
		methods: { 
			//获取分类
			getCategory(){
				var that = this;	 
				var arr=[]; 
		  		//获取所有分类	
		  		this.http.get('/admin/get_category_all')
		  		.then((res) =>{  
		  			that.category = res.data;
		  		})
		  	},
		  	//新增商品
		  	onSubmit() { 
		  		var that = this;  
		  		this.http.post('/admin/add_product',that.forms)
		  		.then((res) =>{  
		  			var res_code=res.status.toString(); //返回结果状态码转字符串取第一位数
					if(res_code.charAt(0) == 2){  
		  				this.$message({
		  					showClose: true,
		  					message: '新增成功',
		  					type: 'success'
		  				});	
		  				this._clsForm();	//清空form数据
						this.upfile_list=[];	//清空上传列表
						this.upfile_list_sku=[];	//清空上传列表
		  			}else{
		  				that.$message({
				          showClose: true,
				          message: res.data.msg,
				          type: 'error'
				        });	 
		  			} 
		  		});  
		  	},
		  	//清空form表单数据
		  	_clsForm(){
		  		var that = this; 
		  		for(var x in that.forms) {
		  			that.forms[x]=""
			    };	 
			    that.forms.sku=[{
					sku_name:"",
					picture:"",
					price:"",
					only_price:"",
					market_price:"",
					stock:"",
				},{
					sku_name:"",
					picture:"",
					price:"",
					only_price:"",
					market_price:"",
					stock:"",
				}] 	
		  	},			
			//上传主图后的回调
			up_ok(res) {
				if(res.code == 201){
					this.forms.img_id = res.id;  
				} 
			},
			//上传规格图后的回调
			up_sku_ok(res) { 
				if(res.code==201 && res.key >= 0){
					this.forms.sku[res.key].picture=res.id;
				}
		    }, 
			//显示或隐藏规格
			sku_btn(){
				if(this.sku_table == false ){
					this.sku_table = true;
				}else{
					this.sku_table = false;
					//清空form.sku的值
				}
			},
			//新增一行规格
			add_sku_line(){ 
				var str = {sku_name:"",price:"",picture:"",only_price:"",market_price:"",stock:""};
				this.forms.sku.push(str);
			},
			//修改商品信息 
			editProduct(id){				
				let loadingInstance = Loading.service({ fullscreen: true });
				var that = this; 			
				this.http.get('/product/'+ id)
				.then((res) =>{   
					that.upfile_list = [{
						url: res.data.imgs
					}];
					for(var x in that.forms){
						that.forms[x]=res.data[x];
					}
					if(that.forms.sku != ''){
						that.sku_table = true;
					}
					that.forms.goods_id = res.data.goods_id; 
					that.sub_btn=false;
				});  	
				loadingInstance.close();	
				
			},
			//提交 修改商品
			onEdit(){ 		 	
				var that = this;  
		  		this.http.post('/admin/edit_product',that.forms)
		  		.then((res) =>{  
		  			this.$message({
		  				showClose: true,
		  				message: '修改成功',
		  				type: 'success'
		  			});	 
		  			that.rest()
		  		});  
			},
			rest() {
				this.$emit('emit_tangou')
			}
		},
		mounted (){ 
			this.getCategory();//获取分类  
			if(this.eid>0){ //大于0为编辑模式
				this.editProduct(this.eid);	
			}
			
		} 
	}
</script>

<style lang="less">
#release{
	.el-date-editor--time-select {
		margin: 0 10px;
	}
	
	.el-form-item__content {
		line-height: 25px;
		;
	}
	.release{text-align: left;}
	.release-buy{font-weight: bold;line-height: 50px;}
	table.gridtable {
		font-family: verdana,arial,sans-serif;
		font-size:11px;
		color:#333333;
		border-width: 1px;
		border-color: #ccc;
		border-collapse: collapse;
	}
	table.gridtable th {
		border-width: 1px;
		padding: 8px;
		border-style: solid; 
		border-color: #ccc;
		background-color: #F2F2F2;
	}
	table.gridtable td {
		border-width: 1px;
		padding: 8px;
		border-style: solid; 
		border-color: #ccc;
		background-color: #ffffff;
	}
	.upload-demo {
		width:50% !important;  
	}  
}
</style>
