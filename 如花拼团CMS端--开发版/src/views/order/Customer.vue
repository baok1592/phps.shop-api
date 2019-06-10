<template>
  <div >
    <transition appear appear-active-class="animated fadeInLeft">
      <div class="customer">
          <el-tabs v-model="activeName" @tab-click="handleClick"> 
            <el-tab-pane label="退款申请" name="first"><customer-b></customer-b></el-tab-pane>
           
          </el-tabs>
      </div>   
    </transition>
  </div>
  
</template>

<script> 
import CustomerB from './components/customer/Customer-b.vue'
export default {
  name: 'Customer',
  data() {
      return {
      	activeName: 'first' 
      }
    },
  components: { 
    CustomerB,
    
  }
}
</script>
 
<style lang="less" scoped="">
.customer{line-height: 30px;text-align: left;} 
</style>
