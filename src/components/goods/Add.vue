<template>
     <div>
          <!-- 导航 -->
          <el-breadcrumb separator-class="el-icon-arrow-right">
               <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
               <el-breadcrumb-item>商品管理</el-breadcrumb-item>
               <el-breadcrumb-item>添加商品</el-breadcrumb-item>
          </el-breadcrumb>
          <!-- 卡片视图区域 -->
          <el-card>
               <el-alert title="添加商品信息" type="info" center show-icon :closable="false"></el-alert>
               <!-- 步骤条  -->
               <el-steps :space="200" :active="activeIndex - 0" finish-status="success" align-center>
                    <el-step title="基本信息"></el-step>
                    <el-step title="商品参数"></el-step>
                    <el-step title="商品属性"></el-step>                    
                    <el-step title="商品图片"></el-step>
                    <el-step title="商品内容"></el-step>
                    <el-step title="完成"></el-step>
               </el-steps>
               <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px" label-position="top">
                    <!-- tabs区域 -->
                    <el-tabs v-model="activeIndex" :tab-position="'left'" :before-leave="beforeTabLeave" @tab-click="tabClicked">
                         <el-tab-pane label="基本信息" name="0">
                              <el-form-item label="商品名称" prop="goods_name">
                                   <el-input v-model="addForm.goods_name"></el-input>
                              </el-form-item>                              
                              <el-form-item label="商品价格" prop="goods_price">
                                   <el-input v-model="addForm.goods_price" type="number"></el-input>
                              </el-form-item>
                              <el-form-item label="商品重量" prop="goods_weight">
                                   <el-input v-model="addForm.goods_weight" type="number"></el-input>
                              </el-form-item>
                              <el-form-item label="商品数量" prop="goods_number">
                                   <el-input v-model="addForm.goods_number" type="number"></el-input>
                              </el-form-item>
                              <el-form-item label="商品分类" prop="goods_cat">
                                        <el-cascader v-model="addForm.goods_cat" expand-trigger="hover" @change="handleChange" :props="cateProps" :options="cateList" clearable change-on-select>
                                        </el-cascader>
                              </el-form-item>
                         </el-tab-pane>
                         <el-tab-pane label="商品参数" name="1">
                              <el-form-item :label="item.attr_name" v-for="item in manyTableData" :key="item.attr_id">
                                   <el-checkbox-group v-model="item.attr_vals" >
                                        <el-checkbox :label="cb" v-for="(cb,i) in item.attr_vals" :key="i" border></el-checkbox>
                                   </el-checkbox-group>
                              </el-form-item>
                         </el-tab-pane>
                         <el-tab-pane label="商品属性" name="2">
                              <el-form-item :label="item.attr_name" v-for="item in onlyTableData" :key="item.attr_id">
                                   <el-input v-model="item.attr_vals"></el-input>
                              </el-form-item>
                         </el-tab-pane>
                         <el-tab-pane label="商品图片" name="3">
                              <el-upload
                                   action="https://jsonplaceholder.typicode.com/posts/"
                                   :on-preview="handlePreview"
                                   :on-remove="handleRemove"
                                   list-type="picture" :on-success="handleSuccess">
                                   <el-button size="small" type="primary">点击上传</el-button>
                                   <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
                              </el-upload>
                         </el-tab-pane>
                         <el-tab-pane label="商品内容" name="4">
                              <!-- 富文本编辑内容 -->
                              <quill-editor id="quill" v-model="addForm.goods_intru">
                              </quill-editor>
                              <el-button type="primary" @click="add">添加商品</el-button>
                         </el-tab-pane>
                    </el-tabs>              
               </el-form>
               
          </el-card>
     </div>
</template>

<script>
import _ from "lodash"
export default {
     data(){
          return{
               activeIndex:'0',
               // 添加商品的表单数据对象
               addForm:{
                    goods_name:'',
                    goods_price:0,
                    goods_weight:0,
                    goods_number:0,
                    // 富文本编辑内容
                    goods_intru:'',
                    attr:[],
                    // 商品所属的分类组
                    goods_cat:[],
               //     图片上传组建的headers请求头对象
                   headerObj:{
                        Authorization:window.sessionStorage.getItem("token")
                   }
               },
               // 商品分类列表
               cateProps:{
                    label:'cat_name',value:'cat_id',
                    children:'children'
               },
               selectedKeys:"",
               // 动态参数数据
               manyTableData:[],
               // 静态参数数据
               onlyTableData:[],
               // 表单验证规则
               addFormRules:{
                    goods_name:{
                          required: true, message: '请输入商品名称', trigger: 'blur'
                    },
                    goods_price:{
                          required: true, message: '请输入商品价格', trigger: 'blur' 
                    },
                    goods_weight:{
                          required: true, message: '请输入商品重量', trigger: 'blur' 
                    },
                    goods_number:{
                          required: true, message: '请输入商品数量', trigger: 'blur' 
                    },
                    goods_cat:{
                          required: true, message: '请选择商品分类', trigger: 'blur' 
                    }

               },
               cateList:[]
                    
               
               
          }
     },
     methods:{
          async getGoodsList(){
               const {data :res} = await this.axios.get("/goods")
                    if(res.status !== 200){
                         return this.$message.error("获取商品分类数据失败！")
                    }
                    this.$message.success("获取商品分类数据成功")
                    this.cateList=res.data.result
                    // console.log(this.cateList)
          },
          handleChange(){
               console.log(this.addForm.goods_cat)
               if(this.addForm.goods_cat.length !== 3){
                    this.addForm.goods_cat = []
               }
          },
          beforeTabLeave(activeName,oldactiveName){
               // console.log('到'+activeName,'离开'+oldactiveName)
               // return false
               if(oldactiveName == '0' && this.addForm.goods_cat.length !== 3){
                    this.$message.error("请选择三级商品分类！")
                    return false
               }

          },
          async tabClicked(){
               // console.log(this.activeIndex)
               if(this.activeIndex == '1'){
                    const {data:res} = await this.axios.get(`/categories/${this.cateId}`,{params:{sel:'many'}})
                    if(res.status !== 200){
                         return this.$message.error("失败！")
                    }
                    this.$message.success("成功")
                    console.log(res.result)
                    res.result.forEach(item => {
                       item.attr_vals =  item.attr_vals.length == 0 ? [] : item.attr_vals.split(" ")
                         // console.log(item.attr_vals)
                         
                    });
                    this.manyTableData=res.result
               }else if(this.activeIndex == '2'){
                    const {data:res} = await this.axios.get(`/categories/${this.cateId}`,{params:{sel:'only'}})
                    if(res.status !== 200){
                         return this.$message.error("获取商品属性失败！")
                    }
                    // console.log(res.result)
                    this.onlyTableData= res.result
               }
          },
          // 处理图片预览效果
          handlePreview(){
               // this.axios.post("/pic").then(res=>{
               //      console.log(res)
               // })
          },
          // 删除图片
          handleRemove(){},
          handleSuccess(respones){
               console.log(respones)

          },
          add(){
               // console.log(this.addForm)
               this.$refs.addFormRef.validate(async valid=>{
                    // console.log(valid)
                    if(!valid){
                         return this.$message.error("请填写商品名称！")
                    }
                    // 执行添加的业务逻辑
                    const form=_.cloneDeep(this.addForm)
                   form.goods_cat = form.goods_cat.join(',')
                   this.manyTableData.forEach(item=>{
                        const newInfo ={
                             attr_id:item.attr_id,
                             attr_value:item.attr_vals.join(' ')
                        }
                        this.addForm.attr.push(newInfo)
                             console.log(newInfo.attr_value)                        

                   })
               //     console.log(form)
               this.onlyTableData.forEach(item=>{
                    const newInfo={
                             attr_id:item.attr_id,
                             attr_value:item.attr_vals
                         }
                        this.addForm.attr.push(newInfo)
                    })
                    form.attr=this.addForm.attr
                    console.log(form)
                    const {data:res} = await this.axios.post("/goodsnew",`fat=${form.attr}&bb=${this.addForm.attr}`)
                    if(res.status !== 200){
                         return this.$message.error("失败false！")
                    }
                    this.$message.success("成功了")
                    this.$router.push("/goods")
               })
               
          }
     },
     created(){
          this.getGoodsList()
     },
     computed:{
          cateId(){
               if(this.addForm.goods_cat.length ==3){
                    return this.addForm.goods_cat[2]
               }
               return null
          }
     }
}
</script>

<style scoped>
.el-breadcrumb{
     margin-bottom: 15px;
     font-size: 12px;
}
.el-steps{margin: 1rem 0;}
.el-checkbox{margin: 10px 10px 0 0 !important;}
.el-button{margin-top: 1rem;outline: none;}
#quill .ql-container p{min-height: 300px !important;}
</style>