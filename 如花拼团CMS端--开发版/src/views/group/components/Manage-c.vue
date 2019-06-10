<template>
  <div class="manage">
    <div class="list" >
      <div class="list-head">
        <div class="liat-head-01">
          <el-row>
            <el-button type="danger" size='small'>删除</el-button> 
          </el-row>
        </div>
        <div class="liat-head-02">
          商品名称：<el-input placeholder="请输入内容" style='width: 70%' size='small'></el-input>
        </div>
        <div class="liat-head-03">
          <el-row>
            <el-button type="primary" size='small'>搜索</el-button> 
          </el-row>
        </div> 
        <div class="liat-head-04">
          时间选择：
        </div> 
        <div class="liat-head-05">
          <el-date-picker v-model="value6" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" >
          </el-date-picker>
        </div>  
      </div>
      <template>
        <el-table  style="width: 100%">
          <el-table-column  prop="nickname"  label="名称"  width="180"></el-table-column>
          <el-table-column  prop="create_time"  label="创建时间"  width="180"></el-table-column>
          <el-table-column  prop="openid"  label="openid"  width="280"></el-table-column>
          <el-table-column  prop="id"  label="ID"  width="80"></el-table-column>
          <el-table-column prop="is_visible" label="是否禁用" width="150">
              <template slot-scope="scope"> 
                <el-switch  @change="onswitch(scope.row.id)" v-model="scope.row.is_visible"  active-color="#409EFF"  inactive-color="#DCDFE6" >
                </el-switch>
              </template>
            </el-table-column>
          <el-table-column  prop="operation"  label="操作" >
            <template slot-scope="scope">
              <el-button @click="handleEdit(scope.row.id)" type="primary" size="small">查看</el-button>
              <el-button type="success" size="small">编辑</el-button>
              <el-button style="margin-left: 10px" type="danger" size="small" slot="reference">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </template>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Manage-c',
  data() {
      return {
        pickerOptions2: {
          shortcuts: [{
            text: '最近一周',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit('pick', [start, end]);
            }
          }, {
            text: '最近一个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
              picker.$emit('pick', [start, end]);
            }
          }, {
            text: '最近三个月',
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
              picker.$emit('pick', [start, end]);
            }
          }]
        },
        value6: '',
        value7: ''
      };
    }
  
}
</script>
 
<style lang="less" scoped="">
.manage{line-height: 30px;text-align: left;} 
.list-head{padding-bottom: 10px;display: flex;}
.liat-head-02{font-size: 14px;padding-left: 10px }
.liat-head-04{padding-left: 10px;}
</style>