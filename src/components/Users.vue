<template>
  <div>
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="9">
          <el-input
            placeholder="请输入内容"
            v-model="queryInfo.query"
            clearable
            @clear="getUserList"
          >
            <el-button
              slot="append"
              icon="el-icon-search"
              @click="getUserList"
            ></el-button>
          </el-input>
        </el-col>
        <el-col :span="3">
          <el-button type="primary" @click="addDialogVisible = true"
            >添加用户</el-button
          >
        </el-col>
      </el-row>
      <el-table :data="userlist" border stripe ref="singleTable">
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column label="姓名" prop="username"></el-table-column>
        <el-table-column label="邮箱" prop="email"></el-table-column>
        <el-table-column label="电话" prop="mobile"></el-table-column>
        <el-table-column label="角色" prop="role_name"></el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope">
            <!-- {{scope.row}} -->
            <el-switch
              v-model="scope.row.mg_state"
              @change="userStateChange(scope.row)"
            >
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180px">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              icon="el-icon-edit"
              @click="showEditDialog(scope.row.id)"
            ></el-button>
            <el-button
              size="mini"
              type="danger"
              icon="el-icon-delete" @click="removeUser(scope.row.id)"
            ></el-button>
            <el-tooltip
              effect="light"
              content="分配角色"
              placement="top"
              :enterable="false">
              <el-button
                size="mini"
                type="warning"
                icon="el-icon-setting" @click="setRole(scope.row)"
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryInfo.pagenum"
        :page-sizes="[1, 2, 5, 10]"
        :page-size="queryInfo.pagesize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="4"
      >
      </el-pagination>
    </el-card>
    <el-dialog
      title="添加用户"
      :visible.sync="addDialogVisible"
      width="50%"
      @close="addDialogClosed"
    >
      <el-form
        :model="addForm"
        :rules="addFormRules"
        ref="addFormRef"
        label-width="80px"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="addForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="addForm.password"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="addForm.email"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="mobile">
          <el-input v-model="addForm.mobile"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="addUser">确定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      title="修改用户"
      :visible.sync="editDialogVisible"
      width="50%"
      @close="editDialogClose"
    >
      <el-form
        :model="editForm"
        :rules="editFormRules"
        ref="editFormRef"
        label-width="70px"
      >
        <el-form-item label="用户名">
          <el-input v-model="editForm.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="editForm.email"></el-input>
        </el-form-item>
        <el-form-item label="手机号" prop="mobile">
          <el-input v-model="editForm.mobile"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button @click="editUserInfo">确定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      title="分配角色"
      :visible.sync="setRoleDialogVisible"
      width="50%" @close="setRoleDialogClosed">
      <div>
        <p>当前的用户: {{userInfo.username}}</p><br>
        <p>当前的角色: {{userInfo.role_name}}</p><br>
        <p>分配新角色:
          <el-select v-model="selectedRoleId" placeholder="请选择">
            <el-option
              v-for="item in roleList"
              :key="item.id"
              :label="item.roleName"
              :value="item.id">
            </el-option>
          </el-select>
        </p>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="setRoleDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="saveRoleInfo">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<style scoped>
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 12px;
}
.el-card {
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.6) !important;
  font-size: 14px !important;
}
.el-table {
  margin-top: 15px;
  white-space: nowrap;
}
.el-table div.cell {
  white-space: nowrap;
}
</style>
<script>
export default {
  data() {
    // 验证邮箱规则
    let checkEmail = (rule, value, cb) => {
      const regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
      if (regEmail.test(value)) {
        return cb();
      }
      cb(new Error("请输入合法的邮箱"));
    };
    // 手机号验证
    let checkMobile = (rule, value, cb) => {
      const regMobile = /^(0|86|17951)?(13[0-9]|15[0123456789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
      if (regMobile.test(value)) {
        return cb();
      }
      cb(new Error("请输入合法的手机号"));
    };
    return {
      // 获取用户列表的参数对象
      queryInfo: {
        query: "",
        // 当前的页数
        pagenum: 1,
        // 当前页的信息数
        pagesize: 4,
      },
      // 用户列表
      userlist: [],
      // 角色列表
      roleList:[],
      total: 0,
      // 添加用户对话框显示与隐藏
      addDialogVisible: false,
      // 修改用户对话框显示与隐藏
      editDialogVisible: false,
      // 分配角色用户对话框现实与隐藏
      setRoleDialogVisible:false,  
      // 需要被分配角色的用户信息    
      userInfo:{},
      // 选中的角色
      selectedRoleId:'',
      // 查询到的用户信息对象
      editForm: {},
      // 添加用户表单数据
      addForm: {
        username: "",
        password: "",
        email: "",
        mobile: "",
      },
      // 添加用户的表单规则
      addFormRules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          {
            min: 3,
            max: 10,
            message: "用户名的长度在3~10个字符之间",
            trigger: "blur",
          },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          {
            min: 6,
            max: 15,
            message: "密码的长度在6~15个字符之间",
            trigger: "blur",
          },
        ],
        email: [
          { required: true, message: "请输入邮箱", trigger: "blur" },
          { validator: checkEmail, trigger: "blur" },
        ],
        mobile: [
          { required: true, message: "请输入手机号", trigger: "blur" },
          { min: 11, max: 11, message: "手机号为11位数字哟", trigger: "blur" },
          { validator: checkMobile, trigger: "blur" },
        ],
      },
      // 修改用户表单规则
      editFormRules: {
        email: [
          { required: true, message: "请输入邮箱", trigger: "blur" },
          { validator: checkEmail, trigger: "blur" },
        ],
        mobile: [
          { required: true, message: "请输入手机号", trigger: "blur" },
          { min: 11, max: 11, trigger: "blur", message: "手机号为11位数字" },
          { validator: checkMobile, trigger: "blur" },
        ],
      },
    };
  },
  created() {
    this.getUserList();
  },
  methods: {
    async getUserList() {
      const { data: res } = await this.axios.get("/users", {
        params: this.queryInfo,
      });
      if (res.meta.status !== 200) return this.$message.error("获取数据失败");
      // console.log(res);
      this.userlist = res.data.users;
      this.total = res.data.total;
    },
    // 监听pagesize
    handleSizeChange(newSize) {
      // console.log(newSize)
      this.queryInfo.pagesize = newSize;
      this.getUserList();
    },
    handleCurrentChange(newPage) {
      this.queryInfo.pagenum = newPage;
      this.getUserList();
    },
    // 修改用户状态
    async userStateChange(userinfo) {
      // console.log(userinfo);
      const { data: res } = await this.axios.put(
        "/users",
        `id=${userinfo.id}&state=${userinfo.mg_state}`
      );
      if (res.meta.status !== 200) {
        userinfo.mg_state = !userinfo.mg_state;
        return this.$message.error("更新用户状态失败！");
      }
      this.$message.success("更新用户状态成功");
    },
    addDialogClosed() {
      this.$refs.addFormRef.resetFields();
    },
    addUser() {
      this.$refs.addFormRef.validate(async (valid) => {
        // console.log(valid)
        if (!valid) return;
        // 发起添加用户的网络请求
        const { data: res } = await this.axios.post(
          "/users",
          `username=${this.addForm.username}&password=${this.addForm.password}&mobile=${this.addForm.mobile}`
        );
        if (res.meta.status !== 200) {
          this.$message.error("添加用户失败,用户名已存在");
        } else {
          this.$message.success("添加用户成功！");
        }
      });
    },
    // 修改用户对话框
    async showEditDialog(id) {
      // console.log(id)
      const { data: res } = await this.axios.get("/users2?lid=" + id);
      if (res.meta.status !== 200) return this.$message.error("获取数据失败");
      this.editForm = res.data;
      // console.log(res);
      this.editDialogVisible = true;
    },
    editDialogClose() {
      this.$refs.editFormRef.resetFields();
    },
    editUserInfo() {
      this.$refs.editFormRef.validate(async (valid) => {
        // console.log(valid)
        if (!valid) return;
        const { data: res } = await this.axios.put(
          "/usersn/",
          `lid=${this.editForm.lid}&email=${this.editForm.email}&mobile=${this.editForm.mobile}`
        );
        if (res.meta.status !== 200) {
          return this.$message.error("修改用户信息失败");
        }
        // 关闭对话框
        this.editDialogVisible = false;
        // 再次获取数据
        this.getUserList();
        // 弹出反馈信息
        this.$message.success("更新用户信息成功");
      });
    },
  async  removeUser(id){
  const confirmResult=await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'

          // 如果用户确认删除，打印confirm
          // 如果用户取消删除，打印cancel
        }).catch(error => error)
        // console.log(confirmResult)
        if(confirmResult !== "confirm") return this.$message.info("已取消删除")
        const {data:res}=await this.axios.delete("/users/"+id)
        console.log(res)
        if(res.data.status !== 200){
          return this.$message.error("删除用户失败")
        }
        this.$message.success("删除成功")
        this.getUserList();
    },
   async setRole(userInfo){
      this.userInfo=userInfo
      // 获取所有角色列表
      const {data:res} = await this.axios.get("/roles")
      if(res.status !==200) return this.$message.error("获取角色列表失败！")
      this.roleList=res.data
      this.setRoleDialogVisible= true
    },
    // 点击按钮，角色分配
   async saveRoleInfo(){
      if(!this.selectedRoleId) return this.$message.error("请选择要分配的角色！")
     const {data:res} = await this.axios.put(`/users/${this.userInfo.id}/role`,`rid=${this.selectedRoleId}`)
     if(res.status !== 200){
       return this.$message.error("分配角色失败")
     }
     this.$message.success("分配角色成功")
     this.getUserList()
     this.setRoleDialogVisible =false
    },
    // 清空角色分配
    setRoleDialogClosed(){
      this.userinfo={}
      this.selectedRoleId=''
    }
  },
};
</script>