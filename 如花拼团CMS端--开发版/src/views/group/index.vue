<template>
  <div  v-if="auth">
    <transition appear appear-active-class="animated fadeInLeft">
      <div class="manage">
         <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane label="用户列表" name="first"><manage-a></manage-a></el-tab-pane>
          <el-tab-pane label="管理组" name="second"><manage-b ></manage-b></el-tab-pane>
          <el-tab-pane label="操作日志" name="third"><manage-c></manage-c></el-tab-pane>
        </el-tabs>
      </div>     
    </transition>
  </div>
  
</template>

<script>
import ManageA from './components/Manage-a.vue'
import ManageB from './components/Manage-b.vue'
import ManageC from './components/Manage-c.vue'
export default {
  name: 'Manage',
  data() {
      return {
      	activeName: 'first',
				auth:false      	
      }
    },
  components: {
    ManageA,
    ManageB,
    ManageC,
  }, 
  methods:{
  	handleClick(tab, event) {
        console.log(tab, event);
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
	mounted() {
			this.check_auth('member_list')		
	}
}
</script>
 
<style lang="less" scoped="">
.manage{line-height: 30px;} 
</style>
