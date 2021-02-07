<template>
  <!-- 微信二维码和底部信息 -->
  <div id="footer">
    <div class="footer-container">
      <div class="left pltwo">
        <p>
          <router-link to="/"> 诺心公告</router-link>
          <router-link to="/" class="plone">关于诺心</router-link>
          <router-link to="/" class="plone">客服服务</router-link>
          <router-link to="/" class="plone">食品经营许可证</router-link>
          <router-link to="/" class="plone">生产许可证</router-link>
          <router-link to="/" class="plone">预付费协议</router-link>
          <router-link to="/" class="plone">联系我们</router-link>
        </p>
        <p class="mt-2 font1 colo2">
          <span>如有问题，请联系在新客服。工作时间: 9:00-21:00</span>
        </p>
        <p class="font1">
          copyright©2010-2020 诺心lecake.com版权所有
          <router-link to="/" class="font1">沪ICP10211730号</router-link>
          <router-link to="/" class="font1"
            >沪公网安备31010402003364号</router-link
          >
        </p>
      </div>
      <div class="right pr1 font3">
        <img id="im1" src="../../public/foot/qrCode.png" alt="" />
        <p>关注微信公众号</p>
        <p>可进入微商城</p>
      </div>
    </div>
  </div>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
a {
  color: black;
  text-decoration: none;
}
a:hover {
  text-decoration: none;
  color: tomato;
}
.colo2 {
  color: black !important;
}
.plone {
  padding-left: 22px;
}
.pltwo{padding-left: 25px;}
.pr1{padding-right: 25px;}
.font1 {
  font-size: 14px;
  color: #949494;
}
.font3{font-size: 14px;}
#footer {
  background: white;
  height: 280px;
}
#footer > .footer-container {
  width: 1200px;
  margin: 0 auto;
  padding: 50px 0;
  display: flex;
  justify-content: space-between;
  background: white;
}
#footer .left,#footer .right{height: 140px;box-sizing: border-box;}
#footer .right img {
  width: 85px;
  height: 85px;
  box-sizing: border-box;
  padding: 1px;
  margin-left: 5px;
  border: 1px solid silver;
  text-align: center;
}
#footer .right p:nth-child(2) {
  margin: 0;
  font-size: 14px;
}
#footer .right p:nth-child(3) {
  margin: 0;
  padding-left: 5px;
  font-size: 14px;
}
</style>
