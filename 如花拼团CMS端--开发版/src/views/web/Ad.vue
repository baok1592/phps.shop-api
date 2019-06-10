<template>
  <div id="ad">
    <transition appear appear-active-class="animated fadeInLeft">
      <div class="list" >
        <div class="list-head">   
            <el-row>
              <el-button type="primary" size='small' @click="dialogFormVisible = true">添加广告</el-button> 
                   <el-dialog title="" :visible.sync="dialogFormVisible" width="45%" center>
                <el-form :model="form" >
                  <el-form-item label="广告位名称" :label-width="formLabelWidth">
                    <el-input v-model="form.key_word" auto-complete="off"></el-input>
                  </el-form-item>
                   <el-form-item label="选择广告位" :label-width="formLabelWidth">
                      <el-select v-model="form.banner_id"  >          
                        <el-option v-for="item in banners"  
                        :value="item.id" :label="item.description"></el-option>
                      </el-select>
                   </el-form-item>
                  <el-form-item label="广告图片" :label-width="formLabelWidth">
                    <el-upload class="upload-demo" 
                      :action="upfile_url"
                      :data="upfile_data"
                      :on-success="up_ok"
                      :limit=1 
                      :file-list="upfile_list"
                      :headers="upfile_head" >
                      <el-button size="small" type="primary">点击上传</el-button> 
                    </el-upload>
                  </el-form-item> 
                  
                  
                </el-form>
                <div slot="footer" class="dialog-footer">
                  <el-button type="primary" @click="sub">确 定</el-button>
                </div>
              </el-dialog> 
            </el-row>
        </div>
        <template>
          <el-table :data="list" border style="width: 100%">
             <el-table-column  type="index"  label="序号"  width="50"></el-table-column>
            <el-table-column  prop="key_word"  label="名称"  width="220"></el-table-column>
            <el-table-column  prop="banner.description"  label="所属广告位"  width="220"></el-table-column> 
             <el-table-column  prop="imgs"  label="缩略图"  width="280">
                <template slot-scope="scope">
                  <img :src="scope.row.imgs" with="140" height="70"/>
                </template>                   
             </el-table-column>
            <!-- <el-table-column  prop="id"  label="排序"  width="80">
              <template slot-scope="scope">
                <el-input v-model="input" placeholder="请输入内容"></el-input>
              </template>                 
            </el-table-column> -->
            <el-table-column  prop="operation"  label="操作" >
              <template slot-scope="scope">
                <!-- <el-button type="success" size="small">编辑</el-button>  -->    
            <el-button style="margin-left: 10px" type="danger" size="small" slot="reference" @click="del(scope.row.id,scope.$index)">删除</el-button>
              </template>
            </el-table-column>
        </el-table>
        </template>
      </div>      
    </transition>
    
  </div>
</template>

<script>
import { Loading } from 'element-ui';
import {Api_url} from '@/common/config'
export default {
  name: 'Ad',
  data(){
    return{
        dialogFormVisible: false,
        form: {
          key_word: '',
          img_id:'',
          banner_id: ''
        },
        formLabelWidth: '120px',
        input:'',  
        banners:'',
        upfile_url: Api_url + '/admin/upload/img',
        upfile_data:{
          use:'AD'
        }, 
        upfile_head:{
          token:localStorage.getItem("token")
        },
        upfile_list:[], //上传文件列表
        list:[]
    }
  },
  methods:{
      sub(){
         var that = this;    
          this.http.post('/admin/create_ad',that.form)
            .then((res) =>{    
                that.$message({
                  showClose: true,
                  message: '添加成功',
                  type: 'success'
                });
                for(var x in that.form) {
                  that.form[x]=""
                };
                that.upfile_list=[];
                that.dialogFormVisible = false;
                that.getBannerItems(); 
          });   
      },
      //获取广告位
      getBanners(){
          var that = this;    
          this.http.get('/banners')
            .then((res) =>{  
              console.log(res.data);
              var res_code=res.status.toString(); 
              if(res_code.charAt(0) == 2){  
                that.banners=res.data;
              }  
          });       
      },
      //获取所有广告位下的广告
      getBannerItems(){
          var that = this;             
          let loadingInstance = Loading.service({ fullscreen: true });//显示加载 
          console.log('xxx');
          this.http.get('/banner_all_item')
            .then((res) =>{                
              loadingInstance.close();   //关闭加载 
              var res_code=res.status.toString(); 
              if(res_code.charAt(0) == 2){  
                that.list=res.data;
              }  
          });       
      }, 
      up_ok(res) {
        this.form.img_id = res.id;
      },
       //删除商品
      del(id,index){
        var that = this;  
        this.$confirm('是否删除?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.http.put('/admin/del_ad',{id:id})
          .then((res) =>{     
              that.$message({
                showClose: true,
                message: '删除成功',
                type: 'success'
              });
              that.list.splice(index,1);  
          }); 
        })
      }
  },
  mounted(){
      this.getBanners();
      this.getBannerItems();      
  }


}
</script>
 
<style lang="less">
#ad{
  line-height: 30px;
  text-align: left;   
  .list-head{padding-bottom: 10px}
} 
</style>
