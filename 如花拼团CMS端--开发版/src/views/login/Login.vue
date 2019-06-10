<template>
  <div id="login">
    <div class="login_wrap">

    <div class="wenzi">商城管理后台</div>

    <div id="darkbannerwrap"></div>
    
    <form method="post"> 
        <div class="put"><i class="el-icon-news"></i><input v-model="user" placeholder="用户名"></div>
       <div class="put"><i class="el-icon-edit"></i><input v-model="password" placeholder="密码" type="password" v-on:keyup.enter="sub()" ></div>
         <div >
         <el-row><el-button type="primary" class="btn" @click="sub()"
        >登录</el-button></el-row>
       </div> 
    </form>

  </div>
</div>
</template> 
 
<script>  
export default {
  name: 'Login',
  data (){
    return {
        user:"",
        password:""
    }
  },
  methods:{
    sub(){
        var that=this; 
        this.http.post('/admin/login',
          {username:that.user,password:that.password})
          .then((res) =>{  
             localStorage.setItem("token",res.data.token);
			 localStorage.setItem("oauth",res.data.oauth);
             that.$message({
               showClose: true,
               message: '登陆成功',
               type: 'success'
             });	
			 location.href="../"; 
          }); 
    },
    login(){ 
		const token=localStorage.getItem("token");
		if(token){				  
			location.href="./#/";
		}
    }
  },
  mounted (){   
    this.login(); 
  }
 
} 
</script>
 
<style lang="less">

#login{ 
    padding:0px;
    margin:0px;
    position:absolute;
    top:0px;
    left:0px;
    width:100%;
    height:100%;
    border:hidden; 
}
#login{
    background:url(../../../public/image/login.jpg) repeat left center;
    background-size: cover;
}
 
.login_wrap{
    margin: 180px auto 0 auto;
    min-height: 420px;
    max-width: 420px;
    padding: 40px; 
    margin-left: auto;
    margin-right: auto;
    border-radius: 4px; 
    box-sizing: border-box; 
    text-align:center; 

    .wenzi{
        width: 400px;
        text-align: center;
        font-size:32px;
        color:#fff; 
        letter-spacing:3px;
    }

    .put{
        background-color: #fffff;
        color: #fff;
        padding: 5px 0;
        width: 280px;
        margin-top: 30px;
        border: 2px solid #e0e0e0;
        border-radius:20px;
        margin:30px 0 20px 50px;
        font-size:24px;
    } 
    .put input{
        background:none;
        text-indent: 20px;
        outline:none;border:0px; 
        color: #fff;
        line-height: 40px;
        width:80%;
        font-size:16px;
    }
    .btn{
        width:200px;
        margin-left:40px;
    }
}    
</style>
 

 
 