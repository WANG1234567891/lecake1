<template>
  <div>
          <!-- 导航 -->
          <el-breadcrumb separator-class="el-icon-arrow-right">
               <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
               <el-breadcrumb-item>商品管理</el-breadcrumb-item>
               <el-breadcrumb-item>商品分类</el-breadcrumb-item>
          </el-breadcrumb>
          <!-- 卡片视图区域 -->
          <el-card>
               <el-row :gutter="20">
                    <el-col :span="10">
                         <el-input placeholder="请输入内容" v-model="queryInfo.query" clearable @clear="getGoodsList">
                              <el-button slot="append" icon="el-icon-search" @click="getGoodsList"></el-button>
                         </el-input>
                    </el-col>
                    <el-col :span="4">
                         <el-button type="primary" @click="goAddPage">添加商品</el-button>
                    </el-col>
               </el-row>
               <!-- table区域 -->
               <el-table :data="goodslist" border stripe>
                    <el-table-column type="expand"></el-table-column>
                    <el-table-column label="#" type="index"></el-table-column>
                    <el-table-column label="商品名称" prop="goods_name"></el-table-column>
                    <el-table-column width="90px" prop="goods_price" label="商品价格(元)"></el-table-column>
                    <el-table-column width="50px" prop="good_weight" label="商品重量"></el-table-column>
                    <el-table-column width="100px" prop="add_time" label="创建时间">
                         <template slot-scope="scope">{{scope.row.add_time | dataFormat}}</template>
                    </el-table-column>
                    <el-table-column width="130px" prop="" label="操作">
                         <template slot-scope="scope">
                              <el-button type="primary" size="mini" icon="el-icon-edit"></el-button>
                              <el-button type="warning" size="mini" icon="el-icon-delete" @click="removeById(scope.row.good_id)"></el-button>
                         </template>
                    </el-table-column>
               </el-table>
               <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="queryInfo.pageNum"
                    :page-sizes="[5, 10, 15, 20]"
                    :page-size="queryInfo.pageSize"
                    background
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="total">
               </el-pagination>              
          </el-card>
  </div>
</template>

<script>
export default {
     data(){
          return{
               input3:'',
               // 查询参数对象
               queryInfo:{
                    query:'',
                    pageNum:1,
                    pageSize:10
               },
               // 总数据数
               total:0,
               // 商品列表
               goodslist:[]
          }
     },
     methods:{
          // 根据分页获取对应的商品列表
          async getGoodsList(){
               const {data:res} = await this.axios.get('/goods',{
                    params:this.queryInfo
               })
               if(res.status !== 200) return this.$message.error("获取商品列表失败！");
               this.$message.success("获取商品列表成功")
               this.goodslist = res.data.goods
               this.total = res.data.total
          },
          handleSizeChange(newSize){
               this.queryInfo.pageSize=newSize
               this.getGoodsList()
          },
          handleCurrentChange(newPage){
               this.queryInfo.pageNum=newPage
               this.getGoodsList()

          },
          addPro(){
              
          },
          // 删除操作
          async removeById(id){
              const confirmResult =await  this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
               confirmButtonText: '确定',
               cancelButtonText: '取消',
               type: 'warning'}).catch(error => error)

               if(confirmResult !== 'confirm'){
                    return this.$message.info("已取消删除!")
               }
               const {data:res} =await this.axios.delete(`/goods/${id}`)
               if(res.status !== 200){
                    return this.$message.error("删除失败!")
                    
               }
               this.$message.success("删除成功")
               this.getGoodsList()
          },
          goAddPage(){
               // this.$router.push('/goods/tes')
               this.$router.push('/goods/add')
          }
     },
     created(){
          this.getGoodsList()

     },
}
</script>

<style scoped>
.el-breadcrumb{
     margin-bottom: 15px;
     font-size: 12px;
}
.el-table{margin: 1rem 0;}
.el-button{outline: none;}

</style>