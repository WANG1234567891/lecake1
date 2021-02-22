<template>
  <div>
    <!-- 导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>商品列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 卡片视图区域 -->
    <el-card>
      <el-row>
        <el-col>
          <el-button type="primary"  @click="addCateDialog">添加分类</el-button>
          </el-col>
      </el-row>
      <!-- 表格 -->
      <tree-table class="tree-table" :data="cateList" :columns="columns" :expand-type="false" index-text="#" border :show-row-hover="false" show-index :selection-type="false">
           <template slot="isok" slot-scope="scope">
               <i class="el-icon-success" v-if="scope.row.cat_deleted == false " style="color:lightgreen "></i>
               <i class="el-icon-error" v-else style="color:red "></i>
           </template>
           <template slot="order" slot-scope="scope">
                <el-tag size="mini"  v-if="scope.row.cat_deleted == 1">一级</el-tag>
                <el-tag size="mini" type="success" v-else-if="scope.row.cat_deleted == 2">二级</el-tag>
                <el-tag size="mini" type="warning" v-else>三级</el-tag>
           </template>
           <template slot="opt" slot-scope="scope">
                <el-button size="mini" type="primary" icon="el-icon-edit">编辑</el-button>
                <el-button size="mini" type="danger" icon="el-icon-delete">删除</el-button>
           </template>
      </tree-table><br>

      <!-- 添加分类对话框 -->
     <el-dialog
          title="添加分类"
          :visible.sync="addCateDialogVisible"
          width="50%" @close="addCateDialogClose">
          <el-form status-icon :model="addCateForm" :rules="addCateFormRules" ref="addCateFormRef" label-width="100px">
               <el-form-item label="分类名称:" prop="cat_name">
               <el-input v-model="addCateForm.cat_name"></el-input>
               </el-form-item>
               <el-form-item label="父级分类:" >
                     <el-cascader
                         v-model="selectedKeys"
                         :options="parentList"
                         :props="cascaderProps"
                         expand-trigger="hover"
                         @change="parentCateChange"
                         clearable change-on-select>
                    </el-cascader>
               </el-form-item>
          </el-form>
          <span slot="footer" class="dialog-footer">
          <el-button @click="addCateDialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="addCate">确 定</el-button>
          </span>
     </el-dialog>
      <!-- 分页区域 -->
       <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="queryInfo.pageNum"
      :page-sizes="[ 3, 5, 10, 15]"
      :page-size="queryInfo.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
    </el-card>
  </div>
</template>
<style scoped>
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 12px;
}
.tree-table{
     margin-top: 1rem;
}
</style>
<script>
export default {
  data() {
    return {
     //     商品分类表
         cateList:[],
         total:0,
     //     添加分类对话框的现实与隐藏
         addCateDialogVisible:false,
     //     add分类表单
          addCateForm:{
               // add的分类名称
               cat_name:'',
               // 分类id
               cat_pid:0,
               // 分类等级
               cat_level:0
          },
          // 父级数据
          parentList:[],
          // 指定级联选择器的配置对象
          cascaderProps:{
               value:'cat_id',
               label:'cat_name',
               children:'children'
          },
          // 选中的id数组
          selectedKeys:[],
          addCateFormRules:{
               cat_name:[
               { required: true, message: '请输入分类名称', trigger: 'blur' },
               ],
          },
     //     查询条件
         queryInfo:{
              type:1,
              pageNum:0,
              pageSize:5
         },
         columns:[{
              label:"分类名称",
              prop:"cat_name",
         },{
              label:'是否有效',
          //     将当期案列定义为模板列
              type:'template',
          //     表示当前这一列使用的模板名称
              template:'isok'
         },{
              label:'排序',
          //     将当期案列定义为模板列
              type:'template',
          //     表示当前这一列使用的模板名称
              template:'order'
         },{
              label:'操作',
          //     将当期案列定义为模板列
              type:'template',
          //     表示当前这一列使用的模板名称
              template:'opt'
         }]
    };
  },
  created() {
       this.getCateList()
  },
  methods: {
     //   获取商品分类数据
      async getCateList(){
          const {data:res} =await  this.axios.get("/categ" ,{params:this.queryInfo} )
          if(res.status !== 200) return this.$message.error("获取数据失败！")
          this.$message.success("获取数据成功")
     //    console.log(res)
          this.cateList=res.data.result
          this.total=res.data.total
       },
       handleSizeChange(newPageSize){
            this.queryInfo.pageSize = newPage
           this.getCateList()
       },
       handleCurrentChange(newNum){
          this.queryInfo.pageNum = newNum
           this.getCateList()

       },
     //   添加分类
       addCateDialog(){
            this.getParentList()
            this.addCateDialogVisible = true
       },
     async  getParentList(){
            const {data:res} =await this.axios.get("/categ",{params:this.queryInfo})
            if(res.status !=200) return this.$message.error("获取父级数据失败！")
            this.$message.success("获取父级数据成功")
            this.parentList=res.data.result
          //   console.log(res.data.result)
       },
       parentCateChange(){
          console.log(this.selectedKeys)
          // 如果selectedKeys的length大于0,表示选中了父级分类
          // 反之什么也没选
          if(this.selectedKeys.length > 0){
               // 父级分类id
               this.addCateForm.cat_pid=this.selectedKeys[this.selectedKeys.length - 1]
               // 为当前分类的等级赋值
               this.addCateForm.cat_level=this.selectedKeys.length
               return
          }else{
               // 父级分类id
               this.addCateForm.cat_pid = 0
               // 为当前分类的等级赋值
               this.addCateForm.cat_level = 0

          }
       },
     //   添加新的分类
       addCate(){
          //   console.log(this.addCateForm)
          this.$refs.addCateFormRef.validate( valid=>{
               // 预检验失败
               if(!valid) return
                this.axios.post("/catep",`pid=${this.addCateForm.cat_pid}&name=${this.addCateForm.cat_name}&level=${this.addCateForm.cat_level}`).then(res=>{
                    if(res.status !== 200) return this.$message.error("添加分类失败！")
                    this.$message.success("添加分类成功")
                    this.getCateList()
                    this.addCateDialogVisible=false
                })
          })
       },
     //   监听colse时间，清空表单数据
       addCateDialogClose(){
            this.$refs.addCateFormRef.resetFields()
            this.selectedKeys=[]
            this.addCateForm.cat_level=0
            this.addCateForm.cat_pid=0
       }
  },
};
</script>