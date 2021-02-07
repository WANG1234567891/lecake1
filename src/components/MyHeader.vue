<template>
  <div id="all">
    <div class="twoup">
      <div class="twoup-container">
        <ul class="nav-1">
          <li><img src="../../public/cakepage/logo.png" alt="" /></li>
          <li><router-link to="/" class="font3">首页</router-link></li>
          <li><router-link to="/cake" class="font3">蛋糕</router-link></li>
          <li><router-link to="/oklist" class="font3">OK零食</router-link></li>
          <li>
            <router-link to="/" class="font3"
              >合作专区
              <ul>
                <li>
                  <router-link to="/" class="font3">银行活动</router-link>
                </li>
                <li>
                  <router-link to="/">企业采购</router-link>
                </li>
                <li>
                  <router-link to="/">大客户区</router-link>
                </li>
              </ul>
            </router-link>
          </li>
          <li><router-link to="/" class="font3">立即兑换</router-link></li>
          <li></li>
          <li></li>
          <li>
            <img
              style="vertical-align: middle"
              class="img1"
              src="../../public/cakepage/point.png"
              alt=""
            />
            <router-link to="/" class="font3 pl1 mb1">成都</router-link>
            <router-link to="/" class="font1 color2 pl-1">查询地址</router-link>
          </li>
          <li class="login-touch">
            <img class="img1" src="../../public/cakepage/search.png" alt="" />
            <img class="img1 ml1" src="../../public/cakepage/user.png" alt="" />
            <img class="img1 ml1" src="../../public/cakepage/bag.png" alt="" />
            <ul class="login">
              <li>
                <router-link to="/login">登录</router-link>
              </li>
              <br />
              <li>
                <router-link to="/register">注册</router-link>
              </li>
            </ul>
            <span class="spantop">{{count}}</span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
<style scoped>
/* 通用样式 */
a {
  text-decoration: none;
}
a:hover {
  color: tomato;
}
.img1 {
  width: 25px !important;
  height: 25px !important;
}
.font1 {
  font-size: 12px;
}
.font2 {
  font-size: 14px;
}
.font3 {
  font-size: 16px;
  color: black;
}
.color1 {
  color: tomato;
}
.color2 {
  color: #949494;
}
.bgcolor {
  background: #cca976;
}
.ml1 {
  margin-left: 20px;
}
.pl1 {
  padding-left: 10px;
}
.pl2 {
  padding-left: 15px;
}
.mb1 {
  margin-bottom: 10px !important;
}

/* 导航栏菜单 */
#all {
  min-width: 1200px;
  position: fixed;
  top: 0;
  z-index: 60;
  height: 90px;
}
#all > .twoup {
  width: 100%;
  background: white;
  height: 90px;
  position: fixed;
}
#all > .twoup > .twoup-container {
  margin: 0 auto;
  box-sizing: border-box;
  width: 1215px;
  background: white;
  box-sizing: border-box;
  padding: 30px 0 0 17px;
}
#all > .twoup > .twoup-container > .nav-1 {
  list-style: none;
  display: flex;
  justify-content: space-between;
}
#all > .twoup > .twoup-container > .nav-1 li {
  float: left;
}

#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a {
  position: relative;
}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a > ul {
  position: absolute;
  top: 18px;
  left: -15px;
  width: 94px;
  height: 130px;
  background: white;
  padding-top: 15px;
  box-shadow: 1px 0px 3px 1px #ebebeb;
  display: none;
}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a > ul li[data-v-898691ee] ,#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a:hover > ul[data-v-898691ee],#all > .twoup > .twoup-container > .nav-1 .login-touch:hover .login[data-v-898691ee]{list-style: none;}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a:hover > ul {
  display: list-item;
}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a > ul li {
  text-align: center;
  padding-top: 8px;
  width: 100%;
}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a > ul li a {
  color: black !important;
}
#all > .twoup > .twoup-container > .nav-1 li:nth-child(5) > a > ul li a:hover {
  color: tomato !important;
}
#all > .twoup > .twoup-container > .nav-1 .spantop {
  position: relative;
  top: -15px;
  background: tomato;
  text-align: center;
  color: white;
  font-size: 14px;
  border-radius: 50%;
  padding: 4px;
}
#all > .twoup > .twoup-container > .nav-1 .login-touch {
  position: relative;
}
#all > .twoup > .twoup-container > .nav-1 .login-touch > .login {
  position: absolute;
  top: 27px;
  left: 18px;
  width: 80px;
  height: 80px;
  background: white;
  box-shadow: 1px 0px 3px 1px #ebebeb;
  display: none;
}
#all > .twoup > .twoup-container > .nav-1 .login-touch:hover .login{display: list-item;}
#all > .twoup > .twoup-container > .nav-1 .login-touch > .login li{ text-align: center;width: 100%;padding-top: 10px;}
#all > .twoup > .twoup-container > .nav-1 .login-touch > .login li a{color: black!important;}
#all > .twoup > .twoup-container > .nav-1 .login-touch > .login li a:hover{color: tomato!important;}
</style>
<script>
export default {
  data(){
    return{count:0}
    
  }
}
</script>