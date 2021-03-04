<template>
  <div>
    <!-- 导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>权限列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
         <el-row>
              <el-button type="primary">添加角色</el-button>
         </el-row>
         <el-table :data="roleList" border stripe>
              <el-table-column type="expand">
                   <template slot-scope="scope">
                        <el-row :class="['bd-bottom','pt','flex-center',i1 == 0 ? 'bd-top' :'']" v-for="(item1,i1) in scope.row.children" :key="item1.id">
                             <!-- 渲染一级权限 -->
                             <el-col :span="5">
                                  <el-tag>{{item1.authName}}</el-tag>
                                  <i class="el-icon-caret-right"></i>
                             </el-col>
                             <!-- 渲染二级权限 -->
                             <el-col :span="19">
                                  <el-row :class="['pt' , 'flex-center', i2 !== 0 ? 'bd-top' : '']" v-for="(item2,i2) in item1.children" :key="item2.id">
                                       <el-col :span="8">
                                            <el-tag type="success">{{item2.authName}}</el-tag>
                                             <i class="el-icon-caret-right"></i>
                                       </el-col>
                                       <el-col :span="16">
                                             <el-tag closable @close="removeRightById(scope.row,item3.id)" :class="['mr','mt']" type="warning" v-for="(item3,i3) in item2.children" :key="item3.id">{{item3.authName}}</el-tag>
                                       </el-col>
                                  </el-row>
                             </el-col>
                        </el-row>
                        <!-- <pre>{{scope.row}}</pre> -->
                   </template>
              </el-table-column>
              <el-table-column type="index" label="#"></el-table-column>
              <el-table-column prop="roleName" label="角色名称"></el-table-column>
              <el-table-column prop="roleDesc" label="角色描述"></el-table-column>
              <el-table-column label="操作" width="300px">
                   <template slot-scope="scope">
                        <el-button icon="el-icon-edit" size="mini" type="primary">编辑</el-button>
                        <el-button icon="el-icon-delete" size="mini" type="danger">删除</el-button>
                        <el-button icon="el-icon-setting" size="mini" type="warning" @click="showSetRightDialog(scope.row)">分配权限</el-button>
                   </template>
              </el-table-column>
         </el-table>
    </el-card>
    <!-- 分配权限的对话框 -->
    <el-dialog
     title="分配权限"
     :visible.sync="dialogVisible"
     width="50%" @close="setRightDialogClosed">
     <!-- 树形控件 -->
          <el-tree ref="treeRef" :data="rightsList" :props="treeProps" show-checkbox node-key="id" default-expand-all :default-checked-keys="defkeys"></el-tree>
          <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="allotRights">确 定</el-button>
          </span>
     </el-dialog>

  </div>
</template>
<style scoped>
.bd-top{border-top: 1px solid #eee;}
.bd-bottom{border-bottom: 1px solid #eee;}
.pt{padding-top: 15px!important;}
.mr{margin-right: 4px;}
.mt{margin-top: 4px;}
.el-button{outline: none;}

.flex-center{
     display: flex;align-items: center;
}
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 12px;
}
.el-row{margin-bottom: 8px;padding: 15px;padding-top: 0px;}
</style>
<script>
export default {
     data(){
          return{
               // 所有角色列表
               roleList:[],
               // 控制分配权限的显示与隐藏
               dialogVisible:false,
               // 所有权限的数据
               rightsList:[],
               // 树形控件的属性绑定对象
               treeProps:{
                    label:"authName",
                    children:"children"
               },
               // 默认勾选的节点id
               defkeys:[],
               // 当前即将分配权的角色id
               roleId:''
          }
     },
     methods:{
          async getRoleList(){
               const {data:res} = await this.axios.get("/roles")
               if(res.status !== 200) return this.$message.error("获取角色列表失败")
               this.$message.success("获取角色列表成功")
               this.roleList=res.data
          },
          // 根据id删除对应权限tag    role一级对象，RightId三级节点对象
       async removeRightById(role,RightId){
            let confirm = await  this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
               }).catch(
                    err => err
               // 方式二
               //      () => {
               //      this.$message({
               //      type: 'info',
               //      message: '已取消删除'
               //      });          
               // }
               );
               if(confirm !== "confirm") return this.$message.info("已取消删除！")
               let {data:res} = await this.axios.delete("/roles/" + role.id + "/"+ RightId)
               if(res.meta.status !== 200) return this.$message.error("删除失败！")
               this.$message.success("删除成功")
               role.children=res.data
          },
          // 展示分配权限对话框  role当前角色
        async  showSetRightDialog(role){
             this.roleId=role.id
             const {data:res} =  await this.axios.get("/rightlist")
               if(res.status !== 200 ) return this.$message.error("获取权限数据失败") 
               this.rightsList=res.data
               console.log(this.rightsList)
               // 递归获取三级节点的id
               this.getLeafKeys(role,this.defkeys)
               this.dialogVisible=true
          },
          // 通过递归的形式，获取角色下所有三级权限的id，并保存到defkeys中
          getLeafKeys(node,arr){
               // 如果当前node节点不包含children属性，则是三级节点
               if(!node.children){
                    return arr.push(node.id)
               }
               node.children.forEach(item => {
                    this.getLeafKeys(item,arr)
               });
          },
          // 监听分配权限对话框的关闭事件
          setRightDialogClosed(){
               this.defkeys=[]
          },
          // 点击为角色分配权限
        async  allotRights(){
             const keys= [...this.$refs.treeRef.getCheckedKeys() , ...this.$refs.treeRef.getHalfCheckedKeys()]
          //    console.log(keys)
               let idStr=keys.join(",")
               let rid=`${this.roleId}`
               const {data:res} = await  this.axios.post(`/roles/`+ rid + `/rights`,{ rids:idStr })
               if(res.status !== 200) return this.$message.error("修改权限失败！")
               this.$message.success("修改权限成功")
               this.getRoleList()
               this.dialogVisible =false

          }
     },
     created(){
          this.getRoleList()
     }
};
</script>