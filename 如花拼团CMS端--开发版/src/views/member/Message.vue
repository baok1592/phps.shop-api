<template>
  <div class="message">
    <transition appear appear-active-class="animated fadeInLeft"> 
      <div class="message-mem">
        <div class="message-mem-01">
        	<p>会员信息</p>
            <ul>
               <li>会员名称：{{message.nickname}}</li>
               <li>openid：{{message.openid}}</li>
               <li>创建时间：{{message.create_time}}</li>
               <li>手机：</li>
            </ul>
        </div>
        <div class="message-mem-02">
           <p>地址信息</p> 
           {{message.address[0].province}}{{message.address[0].city}}
        </div>
      
        <div class="message-mem-03">
          <template>
      		  <el-table :data="message2"  border style="width: 100%">
      		    <el-table-column  prop=""  label="序号"  width="50"></el-table-column>
      		    <el-table-column  prop="goods_name"  label="商品名称"  width="180"></el-table-column>
      		    <el-table-column  prop="price"  label="价格"  width="180"></el-table-column>
      		    <el-table-column  prop="stock"  label="总库存"  width="280"></el-table-column>
      		    <el-table-column  prop="sales"  label="销量"  width="180"></el-table-column>
              <el-table-column prop="is_visible" label="是否显示" width="150">
                <template slot-scope="scope"> 
                  <el-switch
                    @change="onswitch(scope.row.category_id)"
                    v-model="scope.row.is_visible"
                    active-color="#409EFF"
                      inactive-color="#DCDFE6">
                  </el-switch>
                </template>
              </el-table-column>
      		    <el-table-column  prop="operation"  label="操作" ></el-table-column>
      		  </el-table>
      		</template>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
export default {
  name: 'Message',
  props:['order_id'],
   data() {
	      return {
	    
	        message:[],
          mid:this.order_id
	      }
	    }, 
	  methods:{
	  	post_message(){
	  		var that = this;
  	  	this.req.post(that.API_PROXY + "/admin/get_user",{id:this.mid}).then((res) => {
    		    that.message = res.data;  //收藏返回的是商品和店铺
    		    
    		})
  	  } 		 
	  }, 
	  //vue生命函数
	  mounted (){ 
	  	this.post_message();  
	  } 
}
</script>
 
<style lang="less" scoped="">

 .message{line-height: 30px;text-align:left;font-size: 14px;}
 .message-mem{border: 1px solid #e0e0e0;margin:5px 5px 20px;}
 .message-mem p{font-weight: bold;}
 .message-mem ul{display: flex}
 .message-mem ul li{list-style:none;padding-right: 80px;}
 .message-mem-01{border-bottom:1px solid #e0e0e0;padding: 5px 10px;}
 .message-mem-02{padding: 5px 10px;}
 .message-mem-03{margin: 5px;}
</style>
