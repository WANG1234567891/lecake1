<template>
  <div class="denglu_container">
    <div class="lenglu_box">
      <div class="avator_box"><img src="../assets/logo.png" alt="" /></div>
    </div>
    <el-form
      ref="loginFormRef"
      :model="loginForm"
      :rules="loginFormRules"
      label-width="0"
      class="login_form"
    >
      <el-form-item prop="username">
        <el-input
          v-model="loginForm.username"
          prefix-icon="el-icon-user-solid"
        ></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          prefix-icon="el-icon-lock"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="login">登录</el-button>
        <el-button type="info" @click="resetLoginForm">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      loginForm: { username: "", password: "" },
      loginFormRules: {
        username: [
          { require: true, message: "请输入用户名", trigger: "blur" },
          { min: 6, max: 12, message: "长度在6到12个字符", trigger: "blur" },
        ],
      },
      password: [
        { require: true, message: "请输入密码", trigger: "blur" },
        { min: 6, max: 8, message: "长度在6到8个字符", trigger: "blur" },
      ],
    };
  },
  methods: {
    resetLoginForm() {
      this.$refs.loginFormRef.resetFields()
    },
    login(){
      this.$refs.loginFormRef.validate(valid=>console.log(valid))
    }
  },
};
</script>