<template>
  <div class="denglu_container">
    <div class="denglu_box">
      <div class="avator_box">
        <img src="../assets/logo.png" alt="" />
      </div>
      <el-form ref="loginFormRef" :model="loginForm" :rules="loginFormRules" label-width="0px" class="login_form">
        <el-form-item prop="username">
          <el-input 
            v-model="loginForm.username"
            prefix-icon="el-icon-user-solid"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password" 
            v-model="loginForm.password"
            prefix-icon="el-icon-lock"
          ></el-input>
        </el-form-item>
        <el-form-item class="btns">
          <el-button type="primary" @click="login">登录</el-button>
          <el-button type="info" @click="resetLoginForm">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<style scoped>
.denglu_container {
  background: #fff;
  height: 100%;
}
.denglu_box {
  width: 450px;
  height: 300px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  background: white;
}
.avator_box {
  height: 130px;
  width: 130px;
  border: 1px solid #eee;
  border-radius: 50%;
  padding: 10px;
  box-shadow: 0 0 10px rgb(223, 170, 170);
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
}
.avator_box img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background: #eee;
}
.login_form {
  position: absolute;
  bottom: 0;
  width: 100%;
  box-sizing: border-box;
  padding: 0 35px;
}
.btns {
  display: flex;
  justify-content: flex-end;
}
.el-button--primary:focus{border: none;outline: none;}
</style>

<script>
export default {
  data() {
    return {
      loginForm: { username: "hhh1234", password: "12345678" },
      loginFormRules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          { min: 3, max: 8, message: "长度在 3 到 8 个字符", trigger: "blur" },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 3, max: 8, message: "长度在 3 到 8 个字符", trigger: "blur" },
        ],
      },
    };
  },methods:{
       resetLoginForm(){
            this.$refs.loginFormRef.resetFields()
       },
       login(){
            this.$refs.loginFormRef.validate(async valid=>{
              // console.log(valid)
              if(!valid) return;
              const {data:res}=await this.axios.post("/login", `username=${this.loginForm.username}&password=${this.loginForm.password}`);
              if(res.code !== 1) return this.$message.error("登录失败");
              this.$message.success("登陆成功")
              // console.log({data:res})
              // 1.将登录成功之后的token，保存到客户端的sessionStorage中
              // 1.1项目中除了登录之外的qitaAPI接口，必须在登录之后才能访问
              // 1.2token只应在当前网站打开期间生效，所以将token保存在sessionStorage中
              // 2.通过编程式导航跳转到后台主页，路由地址是/Home
              window.sessionStorage.setItem("token",res.token="gg")
              this.$router.push("/homet");
              })
       }
  },
};
</script>