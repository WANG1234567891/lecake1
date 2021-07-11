<template>
  <div id="index">
    <my-header></my-header>
    <!-- 轮播图 -->
    <div class="container-fluid mt-5" id="one-carousel">
      <el-carousel :interval="5000" arrow="always" class="carousel" style="">
        <el-carousel-item
          v-for="(item, index) of car"
          :key="index"
          style="height: 555px">
          <img :src="item.CarImg" alt="" style="" />
        </el-carousel-item>
      </el-carousel>
    </div>
    <!-- 会员心享俱乐部 -->
    <div class="center" style="background-color: white">
      <div class="center-1">
        <div class="center-1-1">
          <img src="../../public/index/ahaLogo.png" alt="" />
          <p id="p1">尊享礼遇享不停，升级aha会员</p>
          <p>预计可省￥358+,<router-link to="/">了解更多</router-link></p>
          <router-link to="/" id="a1">立即开通 ￥99/年</router-link>
        </div>
        <div class="center-1-2">
          <img src="../../public/index/ahaRights1.png" alt="" />
        </div>
      </div>
    </div>
    <!-- 第二个轮播图和优惠区域 -->
    <div class="center-2">
      <div class="center-2-container">
        <h2>早餐可以更省心！</h2>
        <h5>元气组合 唤醒晨间活力</h5>
        <a href="">立即查看</a>
        <el-carousel :interval="5000" arrow="always" class="carousels">
          <el-carousel-item
            v-for="(item, index) of carousels"
            :key="index"
            style="height: 300px">
            <img :src="item.url" alt="" class="carou2" />
          </el-carousel-item>
        </el-carousel>
      </div>
    </div>
    <table style="height: 150px"></table>
    <!-- 蛋糕详情图 -->
    <div class="cake">
      <div class="cake-1" v-for="(item, index) of category" :key="index">
        <div class="cake-1-1">
          <div>
            <router-link to="#"><img :src="item.Iimg" alt="" /></router-link>
          </div>
          <p></p>
          <h6>{{ item.Ititle }}</h6>
          <p class="p2">{{ item.Ititle_details }}</p>
          <p class="p3">￥{{ item.Iprice }}</p>
        </div>
      </div>
    </div>
    <!-- 底部热门评论 -->
    <div class="foot">
      <div class="foot-1">
        <h4>- 热门评论 -</h4>
        <div class="foot-1-1">
          <div class="one">
            <p>183****8528 &nbsp;&nbsp; 2020-08-11</p>
            <span>包装完好。蛋糕很好吃,不是很甜腻，味道真的好。造型也很好看,8个人很快就吃完了</span>
          </div><br>
          <div class="two">
            <p>135****8927 &nbsp;&nbsp; 2020-06-27</p>
            <span>美貌的蛋糕，就像美貌的妈妈~口味没的说，老顾客了，品质一如既往地好。希望以后也有这么用心的产品。</span>
          </div><br>
          <div class="three">
            <p>185****6835 &nbsp;&nbsp; 2020-06-22</p>
            <span>在诺心订的最好吃的一次,里面夹的果酱特别好吃配了巧克力牌，很可爱。</span>
          </div>
        </div>
      </div>
    </div>
    <div ref="innerRef" class="inner-container">
         <p class="text" v-for="(text,index) in arr" :key="index">{{text}}</p>
    </div>
    <my-foot></my-foot>
  </div>
</template>
<style>
#all .nav-1 li:first-child > a {
  color: tomato !important;
}
/* 轮播图 */
#one-carousel > .carousel {
  height: 555px;
  margin-top: 100px;
}
#one-carousel > .carousel img {
  height: 100%;
  width: 100%;
}
#one-carousel .el-carousel__item h3 {
  color: #475669;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  height: 555px;
  margin: 0;
}

#one-carousel .el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

#one-carousel .el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}
/* 左右箭头 */
#one-carousel .el-carousel__arrow {
  top: 89% !important;
}
#one-carousel .el-carousel__arrow:focus {
  outline: none;
}

#one-carousel .el-carousel__button {
  border-radius: 50% !important;
  background: tomato !important;
  width: 10px !important;
  height: 10px !important;
}
/* 会员心享俱乐部 */

#index .center {
  padding: 40px 0px;
  width: 100%;
  height: 200px;
  margin-top: 10px;
}

#index .center-2 {
  width: 100%;
  display: flex;
  margin-top: 20px;
}

#index .center-1 {
  margin: 0 auto;
  width: 60%;
}

#index .center-1-1 {
  float: left;
}

#index .center-1-2 {
  float: right;
}

#index .center {
  color: #3e3e3e;
  font-size: 16px;
}

#index .center #p1 {
  margin: 0;
  margin-top: 20px;
}

#index .center-1-1 a {
  color: #cea461;
  text-decoration: underline;
}

#index .center-1-1 #a1,
#index #a2 {
  color: #3e3e3e;
  font-size: 14px;
  display: block;
  width: 163px;
  height: 34px;
  text-decoration: none;
  border: 1px solid black;
  text-align: center;
  line-height: 34px;
  margin-top: 1.3rem;
}
#index .center-1-1 #a1:hover {
  background: #f8c182;
  border: 0;
}
#index .center-1-2 img {
  margin-top: 30px;
}

/* 第二个轮播图和优惠区域 */

#index .center-2-container {
  width: 1200px;
  height: 410px;
  background: #f8c182;
  margin: 0 auto;
  position: relative;
  box-sizing: border-box;
}

#index .center-2-container h2 {
  margin-top: 130px;
  margin-left: 40px;
}
#index .center-2-container h5 {
  margin-top: 30px;
  margin-left: 40px;
}
#index .center-2-container a {
  margin-top: 50px;
  text-decoration: none;
  display: block;
  background: #f8c182;
  width: 160px;
  height: 40px;
  line-height: 40px;
  margin-top: 50px;
  margin-left: 50px;
  text-align: center;
  color: white;
  border: 1px solid white;
}
#index .center-2-container a:hover {
  background: white;
  color: black;
}
#index .center-2-container .carousels {
  width: 760px;
  height: 395px;
  position: absolute;
  top: 75px;
  left: 350px;
}
#index .center-2-container .carou2 {
  height: 395px;
  width: 760px;
}

#index #a2 {
  border: 1px solid white;
  color: white;
}

/* 蛋糕详情图 */

#index .cake {
  width: 1200px;
  height: 650px;
  padding-bottom: 15px;
  margin: 0 auto;
  margin-top: -30px;
  margin-bottom: 25px;
  text-align: center;
  background-color: white;
}

#index .cake-1 {
  width: 100%;
}

#index .cake .cake-1-1 {
  float: left;
  width: 294px;
  height: 300px;
  transition: 2s;
  margin-bottom: 5px;
}

#index .cake-1-1 img {
  width: 250px;
  height: 230px;
  padding-top: 20px;
  margin-bottom: 4px
  ;margin-bottom: .7rem;
  transition: 1s;
}

#index .cake-1-1 img:hover {
  transform: scale(1.07, 1.02);
}

#index .p4 > span {
  background-color: #cea461;
  width: 155px;
  font-size: 12px;
  color: white;
}

#index .cake-1-1 h6 {
  margin: 0;
}

#index .cake-1-1 .p2 {
  font-size: 12px;
  color: #949494;
  margin: .34rem 0;
}

#index .p3 {
  color: #cea461;
}

#index .p4 {
  margin-bottom: 5px;
}

#index .cake-1-1:hover {
  background-color: #e6aba7;
  box-shadow: 0px 0px 7px 5px rgb(216, 214, 214);
  border: 0px solid rgb(211, 205, 205);
}

/* 底部热门评论 */

.foot {
  width: 1200px;
  margin: 1rem auto;
}

.foot h4 {
  text-align: center;
}
.foot-1-1 div p{margin-bottom: .5rem;}
/* 在线客服 */

#index #bot {
  width: 80px;
  height: 80px;
  background: white;
  border: 1px solid white;
  box-sizing: border-box;
  padding: 10px;
  text-decoration: none;
  font-size: 14px;
  color: #000000;
  display: block;
  position: fixed;
  top: 250px;
  right: 60px;
}

#index #bot img:hover {
  background: coral;
}

.inner-container{
  overflow: hidden;
  position: absolute;
  width: 200px;
  height: 50px;
  top: 400px;
  left: 80px;
  z-index: 20;
}
.text{     
     animation: myMove 5s linear infinite;
     text-align: center;
     line-height: 15px;
     width: 100%;height: 100%;
     animation-fill-mode: forwards;
     font-size: 14px;
     font-weight: bold;
}
/*文字停顿滚动*/
@keyframes myMove {
  0% {
    transform: translateY(0);
  }
  10% {
    transform: translateY(-30px);
  }
  20% {
    transform: translateY(-30px);
  }
  30% {
    transform: translateY(-60px);
  }
  40% {
    transform: translateY(-60px);
  }
  50% {
    transform: translateY(-90px);
  }
  60% {
    transform: translateY(-90px);
  }
  70% {
    transform: translateY(-120px);
  }
  80% {
    transform: translateY(-120px);
  }
  90% {
    transform: translateY(-150px);
  }
  100% {
    transform: translateY(-150px);
  }
}

</style>
<script>
export default {
  data() {
    return {
      car: [],
      arr:[
           'hello',
           '抓住！草莓季の尾巴  草莓季人气蛋糕 享限时8折',
           '扑通扑通！我的少女心 梦幻马卡龙塔 限时立减100元',
           '风靡Ins  甜品“焦”点来袭 人气巴斯克限时免费加大  2磅仅￥218', 
           '「金」运降喜  福寿安康 金运纳福礼包来袭 享限时折扣',
           '风靡Ins  甜品“焦”点来袭 人气巴斯克限时免费加大  2磅仅￥218'
      ],
      carousels: [
        { url: require("../../public/carousel/lunbotwo.jpg") },
        { url: require("../../public/carousel/lunboone.jpg") },
        { url: require("../../public/carousel/lunbofour.jpg") },
      ],
      category: [],
    };
  },
  methods:{
  },
  mounted() {
    //通过axios工具向Web服务器发送请求以获取文章分类的数据
    this.axios.get("/category").then((res) => {
      this.category = res.data.results;
      // console.log(res.data.results);
          // 评论区

    });
    this.axios.get("/carousel").then((res) => {
      this.car = res.data.results;
      // console.log(res.data.results);
    });
    
  },
};
</script>