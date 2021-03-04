<template>
     <div>
          <!-- 导航 -->
          <el-breadcrumb separator-class="el-icon-arrow-right">
               <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
               <el-breadcrumb-item>商品管理</el-breadcrumb-item>
               <el-breadcrumb-item>分类参数</el-breadcrumb-item>
          </el-breadcrumb>
          <!-- 卡片视图区域 -->
          <el-card>
                 <el-alert title="注意:只允许为第三级分类设置相关参数" type="warning" :closable="false" show-icon></el-alert>
               <!-- 选择商品分类 -->
               <el-row>
                    <el-col>
                         <span>选择商品分类 :</span>
                         <el-cascader
                         v-model="selectedCateKeys"
                         expand-trigger="hover"
                         :options="cateList"
                         :props="cateProps"
                         @change="handleChange" clearable change-on-select></el-cascader>
                    </el-col>
               </el-row>
               <!-- tabs页签 -->
               <el-tabs v-model="activeName" @tab-click="handleTabClick">
                    <el-tab-pane label="动态参数" name="many">
                         <el-button class="elbtn" type="primary" size="mini" :disabled="isBtnsdisable" @click="addDialogVisible = true">添加参数</el-button>
                         <!-- 动态参数表格 -->
                         <el-table :data="manyTableData" border stripe>
                              <el-table-column type="expand">
                                   <template slot-scope="scope">
                                        <el-tag closable v-for="(item,i) in scope.row.attr_vals" :key="i" @close="handleColse(i,scope.row)">{{item}}</el-tag>
                                        <el-input class="input-new-tag"  v-if="scope.row.inputVisible" v-model="scope.row.inputValue" ref="saveTagInput" size="small" @keyup.enter.native="handleInputConfirm(scope.row)"
                                        @blur="handleInputConfirm(scope.row)">
                                        </el-input>
                                        <el-button v-else class="button-new-tag" size="small" @click="showInput(scope.row)">+ New Tag</el-button>
                                   </template>
                              </el-table-column>
                              <el-table-column label="#" type="index"></el-table-column>
                              <el-table-column label="参数名称" prop="cat_name"></el-table-column>
                              <el-table-column label="操作">
                                   <template slot-scope="scope">
                                        <el-button size="mini" type="primary" icon="el-icon-edit" @click="showEditDialog(scope.row.attr_id)">编辑</el-button>
                                        <el-button size="mini" type="warning" icon="el-icon-delete" @click="removeParams(scope.row.attr_id)">删除</el-button>
                                   </template> 
                              </el-table-column>
                         </el-table>
                    </el-tab-pane>
                    <el-tab-pane label="静态属性" name="only">
                         <el-button class="elbtn" type="primary" size="mini" :disabled="isBtnsdisable"  @click="addDialogVisible = true">添加属性</el-button>
                         <!-- 静态参数表格 -->                         
                         <el-table :data="onlyTableData" border stripe>
                              <el-table-column type="expand">
                                   <template slot-scope="scope">
                                        <el-tag closable v-for="(item,i) in scope.row.attr_vals" :key="i" @close="handleColse(i,scope.row)">{{item}}</el-tag>
                                        <el-input class="input-new-tag"  v-if="scope.row.inputVisible" v-model="scope.row.inputValue" ref="saveTagInput" size="small" @keyup.enter.native="handleInputConfirm(scope.row)"
                                        @blur="handleInputConfirm(scope.row)">
                                        </el-input>
                                        <el-button v-else class="button-new-tag" size="small" @click="showInput(scope.row)">+ New Tag</el-button>
                                   </template>
                              </el-table-column>
                              <el-table-column label="#" type="index"></el-table-column>
                              <el-table-column label="属性名称" prop="cat_name"></el-table-column>
                              <el-table-column label="操作">
                                   <template slot-scope="scope">
                                        <el-button size="mini" type="primary" icon="el-icon-edit" @click="showEditDialog(scope.row.attr_id)">编辑</el-button>
                                        <el-button size="mini" type="warning" icon="el-icon-delete" @click="removeParams(scope.row.attr_id)">删除</el-button>
                                   </template> 
                              </el-table-column>
                         </el-table>
                    </el-tab-pane>
               </el-tabs>

               <el-dialog :title=" '添加' + titleText " :visible.sync="addDialogVisible" width="50%" @close="addCateDialogClose">
                    <el-form status-icon :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
                         <el-form-item :label="titleText" prop="cat_name">
                         <el-input v-model="addForm.cat_name"></el-input>
                         </el-form-item>
                    </el-form>
                    <span slot="footer" class="dialog-footer">
                         <el-button @click="addDialogVisible = false">取 消</el-button>
                         <el-button type="primary" @click="addParams">确 定</el-button>
                    </span>
               </el-dialog>

               <el-dialog :title=" '修改' + titleText " :visible.sync="editDialogVisible" width="50%" @close="editDialogClose">
                    <el-form status-icon :model="editForm" :rules="editFormRules" ref="editFormRef" label-width="100px">
                         <el-form-item :label="titleText" prop="cat_name">
                              <el-input v-model="editForm.cat_name"></el-input>
                         </el-form-item>
                    </el-form>
                    <span slot="footer" class="dialog-footer">
                         
                         <el-button @click="editDialogVisible = false">取 消</el-button>
                         <el-button type="primary" @click="editParams">确 定</el-button>
                    </span>
               </el-dialog>
               

          </el-card>

     </div>
</template>
<style scoped>
.el-breadcrumb{
     margin-bottom: 15px;
     font-size: 12px;
}
.el-alert{margin-bottom: 1rem;}
.elbtn{margin-bottom: 1rem;}
.el-button,button{outline: none;}
.el-tag{margin-right: .5rem;margin-top: 0.4rem;}
.input-new-tag{width: 9rem;margin-top: .5rem;}
.button-new-tag,.input-new-tag{margin-top: .5rem;}
</style>
<script>
export default {
     data(){
          return{
               // 商品分类表
               cateList:[],
               // 查询条件
               queryInfo:{type:1},
               activeName:"many",
               // 动态表格数据
               manyTableData:[],
               // 静态表格数据
               onlyTableData:[],
               // 级联选择器配置对象
               cateProps:{
                    value:"cat_id",
                    label:"cat_name",
                    children:"children"
               },
               // 添加表单对象
               addForm:{
                    cat_name:""
               },
               // 修改表单对象
               editForm:{
                    cat_name:"",
                    attr_id:"0"
               },
               // 添加表单对象验证规则
               addFormRules:{
                    cat_name:[ 
                         { required: true, message: '请输入参数名称', trigger: 'blur' },
                ]},
               //  修改表单对象验证规则
                editFormRules:{
                    cat_name:[ 
                         { required: true, message: '请输入参数名称', trigger: 'blur' },
                ]},         
               selectedCateKeys:[],
               addDialogVisible:false,
               editDialogVisible:false,

               // bug区域无效的，仅做初次调试
               // // 控制input和button显示
               // inputVisible:false,
               // inputValue:'',

          }
     },
     created(){
          this.getCateList()
     },     
     methods:{
         async getCateList(){
               const {data:res} =await this.axios.get("/categ",{params:this.queryInfo})
               if(res.status !== 200 ) return this.$message.error("获取商品分类失败！")
               this.$message.success("获取分类表成功")
               this.cateList=res.data.result
          },
          // 级联选择框改变
           handleChange(){
               this.getParamsData()
          },
          handleTabClick(){
               // console.log(this.activeName)
               this.getParamsData()
          },
         async getParamsData(){
              
               // 证明选中的不是三级分类
               if(this.selectedCateKeys.length !== 3){
                    this.selectedCateKeys = []
                    this.manyTableData = []
                    this.onlyTableData = []
                    return
               }
               // console.log(this.selectedCateKeys)
               const {data:res} = await this.axios.get(`/categ/${this.cateId}/${this.activeName}`)
               if(res.status !== 200) return this.$message.error("失败！")
               this.$message.success("成功")
               res.data.result.forEach(item => {
                    item.attr_vals=item.attr_vals ? item.attr_vals.split(" ") : []
                    // console.log(item.attr_vals)
                    // 控制文本框显示与隐藏
                    item.inputVisible = false
                    // 文本框输入的值
                    item.inputValue = ''
               });

               if(this.activeName == "many"){
                    this.manyTableData = res.data.result
               }else{
                    this.onlyTableData = res.data.result
               }
               // console.log(res)
          },
          async saveAttrVals(){
               // 需要发起请求，保存这次操作
              

          },
          addCateDialogClose(){
               this.$refs.addFormRef.resetFields()
          },
          // 按钮添加参数
          addParams(){
               
              this.$refs.addFormRef.validate(async valid =>{
                    if(!valid) return
                    const {data:res} = await this.axios.post(`/catepa/${this.cateId}/${this.activeName}`,`attr_name=${this.addForm.cat_name}`)
                    if(res.status !== 200 ) return this.$message.error("失败！")
                    this.$message.success("ok")
                    this.addDialogVisible =false
                    this.getCateList()
                   
              })
          },
          // 编辑确定
          editParams(){
               // console.log(this.editForm.attr_id)  无法获取bug为 this.editForm.attr_id}
               this.$refs.editFormRef.validate(async valit =>{
                    if(!valit) return
                    const {data:res} = await this.axios.put(`/categories/${this.cateId}/${this.editForm.attr_id}`,`cname=${this.editForm.cat_name}&aname=${this.activeName}`)
                    if(res.status !== 200 ) return this.$message.error("失败！")
                    this.$message.success("修改参数成功")
                    this.getParamsData()
                    this.editDialogVisible = false
               })
          },
          // 按钮展示修改的对话框
         async showEditDialog(attr_id){
               const {data:res} =await this.axios.get(`/categories/${this.cateId}/${attr_id}`,{params:this.activeName})
               if(res.status !== 200 ) return this.$message.error("失败！")
               this.$message.success("ok")
               this.editForm=res.data
               this.editDialogVisible = true

          },
          // 清空修改的表单
          editDialogClose(){
               this.$refs.editFormRef.resetFields() 
          },
          // 删除操作
        async  removeParams(attr_id){
             let confirmResult =await this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
               }).catch(err => err)
               console.log(confirmResult)
               if(confirmResult !== 'confirm'){
                    return this.$message.info("已取消删除！")
               }

               const {data:res} = await this.axios.delete(`/catedelete/${this.cateId}/${attr_id}`)
               if(res.status !=200){
                    return this.$message.error("删除参数失败！")
               }
               this.$message.success("删除成功")
               this.getParamsData()
          },
          // 文本框blur和enter时触发的
          async handleInputConfirm(row){
               // console.log(row.inputValue)
               // 为空时
               if(row.inputValue.trim().length == 0){
                    console.log(row.inputValue)
                    row.inputValue = ''
                    row.inputVisible = false
                    return
               }
               // 不为空时
               row.attr_vals.push(row.inputValue.trim())
               // button重启
               row.inputValue = ''
               row.inputVisible = false
               // 需要发起请求，保存这次操作
              this.saveAttrParams(row)
          },
          // 显示文本输入框
          showInput(row){
               row.inputVisible =true
               // nextTick作用，当页面重新渲染完成，才会调用指定的回调
               this.$nextTick(_ => {
                    this.$refs.saveTagInput.$refs.input.focus();
               });
          },
          async saveAttrParams(row){
                const {data:res} = await this.axios.put(`/categories/${this.cateId}/${row.attr_id}`,`cat_name=${row.cat_name}&cat_pid=${row.cat_pid}&attr_vals=${row.attr_vals.join(' ')}`               
               )
               if(res.status !== 200){
                    this.$message.error("修改参数失败！")
               }
               this.$message.success("ok")
          },
          // 删除对应的参数可选
          handleColse(i,row){
               // console.log(i,row)
               row.attr_vals.splice(i,1)
               // 向服务器发送请求
              this.saveAttrParams(row)
          }
     },
     computed:{
          // 选中的不是三级分类id，按钮禁用
          isBtnsdisable(){
               if(this.selectedCateKeys.length !== 3){
                    return true
               }
               return false
          },
          // 当前选中的三级分类id
          cateId(){
               if(this.selectedCateKeys.length === 3){
                    return this.selectedCateKeys[2]
               }
               return null
          },
          // 计算动态标题的文本
          titleText(){
               if(this.activeName == 'many'){
                    return '动态参数'
               }else{
                    return '静态属性'
               }
          }
     }

     
}
</script>