<template>
  <div class="">
    <el-form ref="form" :model="form" label-width="100px">
	  <el-form-item label="网站" style='width: 80%'>
	    <el-input v-model="form.name"></el-input>
	  </el-form-item>
	  <el-form-item label="官方" style='width: 80%'>
	    <el-input v-model="form.wap" ></el-input>
	  </el-form-item>
	  
	</el-form>
  </div>
</template>

<script>
export default {
  name: 'Set-c',
  data() {
      return {
        form: {
          name: '1',
          wap:'3',
        
        }
      }
    },
    methods:{
  
  }, 
  //vue生命函数
  mounted (){ 
  	
  } 
}
</script>
 
<style lang="less" >
 
</style>
