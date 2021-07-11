<template>
  <div id="login">
    <div class="topper">
      <div class="top">
        <img src="../../public/register/logo_new.png" alt="" />
      </div>
      <!-- 登录区域开始 -->
    </div>
    <div class="center">
      <table></table>
      <div class="login">
        <div>
          <mt-navbar v-model="active">
            <mt-tab-item id="1" class="one">账户密码登录</mt-tab-item>
            <mt-tab-item id="2" class="one">手机验证登录</mt-tab-item>
          </mt-navbar>
          <mt-tab-container v-model="active">
            <mt-tab-container-item id="1">
              <mt-field
                placeholder="请输入用户名"
                type="text"
                v-model="username"
                @blur.native.capture="checkUsername"
              >
              </mt-field>
              <mt-field
                placeholder="请输入密码"
                type="password"
                v-model="password"
                @blur.native.capture="checkPassword"
              >
              </mt-field>
              <mt-button
                class="my-button"
                type="danger"
                size="large"
                @click="handle"
                >立即登录</mt-button
              >
              <div class="forgit mb-3">
                <router-link to="/" class="font2 color2 pr1"
                  >忘记密码</router-link
                >
                <span class="font2">还没有账号？</span>
                <router-link to="/" class="font2 color1">立即注册</router-link>
              </div>
              <div class="weixin font1">
                <p>------请他登录方式------</p>
                <div class="imgs">
                  <img
                    class="mr-3"
                    src="../../public/register/weixin.png"
                    alt=""
                  />
                  <img src="../../public/register/QQ.png" alt="" />
                </div>
              </div>
            </mt-tab-container-item>
            <mt-tab-container-item id="2">
              <mt-field
                type="text"
                v-model="username"
                placeholder="请输入用户名"
                @blur.native.capture="checkUsername"
                :state="usernameState"
              >
              </mt-field>
              <mt-field
                type="password"
                v-model="password"
                placeholder="请输入密码"
                @blur.native.capture="checkPassword"
              >
              </mt-field>
              <mt-button
                class="my-button"
                type="danger"
                size="large"
                @click="handle"
                >立即登录</mt-button
              >
              <div class="forgit mb-3">
                <router-link to="/" class="font2 color2 pr1"
                  >忘记密码</router-link
                >
                <span class="font2">还没有账号？</span>
                <router-link to="/" class="font2 register">立即注册</router-link>
              </div>
              <div class="weixin font1">
                <p>------请他登录方式------</p>
                <div class="imgs">
                  <img
                    class="mr-3"
                    src="../../public/register/weixin.png"
                    alt=""/>
                  <img src="../../public/register/QQ.png" alt="" />
                </div>
              </div>
            </mt-tab-container-item>
          </mt-tab-container>
        </div>
      </div>
    </div>
    <my-foot></my-foot>
  </div>
</template>
<style>
/* 定义公有样式 */
.color1,.register {
  color: #fe4320 !important;
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
/* 可进入微商城 */
#login .center {
  background: url("../../public/register/register.jpg") no-repeat;
  height: 520px;
}
#login .center .login {
  width: 370px;
  height: 439px;
  padding: 20px 60px;
  background: white;
  position: relative;
  margin: 40px 1030px;
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
.weixin{margin-top: 2.5rem;}
.weixin p {
  text-align: center;
}
#login .center .login .imgs {
  padding-left: 85px !important;
}
#login .center .login .mint-navbar a:first-child .mint-tab-item-label {
  border-right: 1.6px solid black;
  height: 15px;
}
#login .center .login .my-button {
  width: 250px;
  height: 50px;
  background-color: #fe4320;
  margin: 1.3rem auto;
  line-height: 50px;
}
#login .center .login .my-button:focus {
  outline: none;
}
#login .imgs img{margin: 2rem 0;}
</style>
<script>
export default {
  data() {
    return {
      active: "1",
      username: "",
      password: "",
      usernameState: "",
      passwordState: "",
    };
  },
  methods: {
    handle() {
      if (this.checkUsername() && this.checkPassword()) {
        //现在要发送相关的用户名、密码到web服务器
        // 换至vuex中发送请求
        let str=`username=${this.username}&password=${this.password}`
        this.$store.dispatch('login_actions',str)
        // this.axios
        //   .post("/login", `username=${this.username}&password=${this.password}`)
        //   .then((res) => {
        //     if (res.data.code == 1) {
        //       alert("登陆成功Welcome here!");
        //       localStorage.setItem('isLoinged',1)
        //       localStorage.setItem('userInfo',JSON.stringify(res.data.userInfo))
        //       this.$store.commit('login_mutations',res.data.userInfo)
        //       this.$router.push("/");
        //     } else {
        //       (this.username = ""),
        //         (this.password = ""),
        //         alert("登录失败"),
        //         this.$router.push("/login");
        //     }
        //   });
      }
    },
    checkUsername() {
      let username = this.username;
      let reg_username = /^[0-9a-zA-Z]{6,12}$/;
      //校验用户名
      if (reg_username.test(username)) {
        // this.$message({
        //   message: "用户名格式正确",
        //   type: "success",
        // });
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
        // this.$message({
        //   message: "密码格式正确哟",
        //   type: "success",
        // });
        return true;
      } else {
        //消息提示框
        this.$toast({
          message: "密码输入错误",
          position: "middle",
          duration: 2000,
        });
        return false;
      }
    },
  },
};
</script>
