<template>
  <div id="login">
    <div class="topper">
      <table></table>
      <div class="top">
        <img src="../../public/register/logo_new.png" alt="" />
        <p class="pt-4">
          用户注册<span class="font1">已有诺心账号?</span
          ><router-link to="/" class="font1 color1">请登录</router-link>
        </p>
      </div>
    </div>
    <!-- 登录区域开始 -->
    <div class="center">
      <table></table>
      <div class="login" style="border: 1px solid red">
        <div>
          <mt-tab-container v-model="active">
            <mt-tab-container-item id="1">
              <mt-field
                label="用户名:"
                type="text"
                v-model="username"
                placeholder="请输入6-12位字母数字的用户名"
                @blur.native.capture="checkUsername"
                :state="usernameState"
              >
              </mt-field>
              <mt-field
                label="密码:"
                type="password"
                v-model="password"
                placeholder="请输入8-15位的字母数字密码"
                @blur.native.capture="checkPassword"
                :state="passwordState"
              >
              </mt-field>
              <mt-field
                label="确认密码:"
                type="password"
                v-model="conpassword"
                placeholder="请再次输入密码"
                @blur.native.capture="checkConpassword"
                :state="conpasswordState"
              ></mt-field>
              <!-- <mt-field label="用户名:"
                type="text"
                v-model="phonenumber"
                placeholder="请输入手机号"
                @blur.native.capture="checkPhonenumber"
                :state="phonenumber"
              ></mt-field> -->
              <mt-button
                class="my-button"
                type="danger"
                size="large"
                @click="register"
                >立即注册</mt-button
              >
            </mt-tab-container-item>
          </mt-tab-container>
        </div>
      </div>
    </div>
    <my-foot></my-foot>
  </div>
</template>
<style scoped>
/* 定义公有样式 */
.color1 {
  color: #fe4320;
}
.color2 {
  color: silver;
}
.color3 {
  color: black;
}
.font1 {
  font-size: 14px !important;
}
.font2 {
  font-size: 12px !important;
}
.font3 {
  font-size: 16px !important;
}
.pr1 {
  padding-right: 68px;
}
.mr {
  margin-right: 117px;
}
#login .topper {
  background: white;
  height: 83px;
  border-bottom: 1px solid silver;
}
#login .top {
  width: 1200px;
  position: relative;
}
#login .top img {
  height: 24px;
  position: absolute;
  left: 100px;
  top: 30px;
}

#login p > a {
  float: right;
}
#login p > span {
  float: right;
}
/* 可进入微商城 */
#login .center {
  background: white;
  height: 520px;
}
#login .center .login {
  width: 430px;
  height: 439px;
  padding: 20px 32px;
  background: white;
  margin: 0 auto;
  margin-top: 80px;
}
#login .center .login .one {
  padding: 17px;
  margin-bottom: 0;
}
#login .mint-field-core {
  border-bottom: 1px solid silver;
}
#login .mint-navbar .mint-tab-item.is-selected {
  color: #fe4320;
}
#login .login .mint-tab-item-label {
  font-size: 14px;
}
#login .center .login .my-button {
  width: 250px;
  height: 50px;
  background-color: #fe4320;
  margin: 0 auto;
  margin-top: 30px;
  line-height: 50px;
}
#login .center .login .my-button:focus {
  outline: none;
}
</style>
<script>
export default {
  data() {
    return {
      active: "1",
      username: "",
      password: "",
      conpassword: "",
      // phonenumber:"",
      passwordState: "",
      conpasswordState: "",
      usernameState: "",
      // phonenumberState: ""
    };
  },
  methods: {
    register() {
      if (
        this.checkUsername() &&
        this.checkPassword() &&
        this.checkConpassword()
      ) {
        let obj = {
          username: this.username,
          password: this.password,
        };
        //现在要发送相关的用户名、密码到web服务器
        this.axios
          .post(
            "/register",
            `username=${this.username}&password=${this.password}`
          )
          .then((res) => {
            if (res.data.code == 1) {
              alert("注册成功");
              this.$router.push("/login");
            } else {
              alert("用户名已存在，请重新输入");
              this.password = "";
              this.username = "";
              this.conpassword=""
            }
          });
      }
    },
    checkUsername() {
      let username = this.username;
      let reg_username = /^[0-9a-zA-Z]{6,12}$/;
      //校验用户名
      if (reg_username.test(username)) {
        this.usernameState = "success";
        return true;
      } else {
        this.$toast({
          //显示短消息提示框(标准写法)
          message: "您输入的用户名有误哦",
          position: "top",
          duration: 2000,
        });
        //简写
        // this.$toast("用户名格式/内容错误")
        this.usernameState = "error";
        return false;
      }
    },
    checkPassword() {
      let password = this.password;
      //校验用户密码
      let reg_password = /^[0-9a-zA-Z\.\-_]{8,15}$/;
      if (reg_password.test(password)) {
        this.passwordState = "success";
        return true;
      } else {
        //消息提示框
        this.$toast({
          message: "密码输入错误",
          position: "top",
          duration: 2000,
        });
        this.passwordState = "error";
        return false;
      }
    },
    checkConpassword() {
      //校验两次密码一致
      let conpassword = this.conpassword;
      let password = this.password;
      if (password == conpassword) {
        this.conpasswordState = "success";
        return true;
      } else {
        this.$toast({
          message: "两次密码不一致",
          position: "top",
          duration: 3000,
        });
        this.conpasswordState = "error";
        return false;
      }
    },
  },
};
</script>
