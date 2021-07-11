<template>
  <div id="details">
    <my-header></my-header>
    <div class="change" style="width: 1200px; height: 520px; margin: 0 auto">
      <el-carousel :interval="5000" arrow="always" class="els">
        <el-carousel-item v-for="(item, k) in carou" :key="k">
          <img :src="detail.Timg2" alt="" />
        </el-carousel-item>
      </el-carousel>
    </div>
    <div id="buy-cont">
      <div class="buy-one">
        <div>
          <div class="d-flex py">
            <div class="font3">商品名 : {{ detail.Ttitle }}</div>
            <div class="font4 color2">单价 : ￥{{ detail.Tprice }}</div>
          </div>
          <div class="mb font1">赠品 : {{ detail.Ttitle_details }}</div>
          <router-link to="/" class="aha">
            <!-- <img :src="detail.Timg" /> -->
            <!-- 放大镜效果 -->
            <img :src="detail.Timg3" alt="" />
            <span class="span1 color1 font1">开通仅¥99 预计可省¥358</span>
            <span class="span2 color1 font1">立即开通</span>
          </router-link>
          <div style="position: relative">
            <div class="w-100"></div>
            <glass
              :img="detail.Timg"
              style="position: absolute; top: 2px"
            ></glass>
            <h4 class="font1 my" id="h4-one">优惠促销</h4>
            <p class="font1">
              <span class="colorbtn bg1 pl1"> 赠品 </span> 赠任意款盒子蛋糕
            </p>
            <h6>查看促销详情</h6>
          </div>
        </div>
      </div>
      <div class="buy-two">
        <div>
          <p class="py2">建议食用人数</p>
          <el-tabs type="border-card">
            <el-tab-pane class="font1">
              <span slot="label"><i class="el-icon-date"></i> 2-4人食 </span>
              <img src="" alt="" />含5套餐具 <img src="" alt="" />约12 x 12 x
              8cm <img src="" alt="" />约540g 甜度:<img src="" alt="" />
            </el-tab-pane>
          </el-tabs>
          <div class="paround">
            <button class="bg2 colorbtn font4" @click="addCount">
              加入购物车+
            </button>
            <button class="bg2 colorbtn font4" @click="routerGo">立即购买</button>
          </div>
        </div>
      </div>
    </div>
    <div class="w12">
      <img :src="detail.Timg4" alt="" />
    </div>
    <div class="w12">
      <img :src="detail.Timg5" alt="" />
    </div>
    <div class="w12">
      <img :src="detail.Timg6" alt="" />
    </div>
    <div class="w12">
      <img :src="detail.Timg7" alt="" />
    </div>
    <div class="w12 main">
      <h2>主要原材料</h2>
      <h4>Main raw materials</h4>
      <div></div>
      <ul class="left">
        <li class="font4">食材配比</li>
        <li>奶油芝士</li>
        <li>芒果果茸</li>
        <li>白巧克力</li>
        <li>稀奶油</li>
      </ul>
      <ul class="right">
        <li class="font4">产地</li>
        <li>新西兰</li>
        <li>法国</li>
        <li>比利时</li>
        <li>新西兰</li>
      </ul>
    </div>
    <div class="about w12">
      <h5>关于食用</h5>
      <h6>About edible</h6>
      <img src="" alt="" />
      <p>适合人群：大众</p>
      <p>适合季节：所有</p>
      <p>保鲜条件：冷藏0~4摄氏度</p>
      <p>食用方法：请收到蛋糕后2-3小时内食用</p>
      <p>*商品以实物为准。</p>
    </div>
    <div class="cup w12">
      <h4>一杯芒芒金露</h4>
      <h5>Very Mango Pomelo Cake</h5>
      <div></div>
      <p>经典“芒柚cp”来咯</p>
      <p>绵密奶盖搭配Q爽波波</p>
      <p>椰子慕斯热情加持</p>
      <p>加入赤藓糖醇、高膳食纤维、健康有益菌</p>
      <p>满杯活力，赶快来拥有！</p>
    </div>
    <div class="w12">
      <img :src="detail.Timg8" alt="" />
    </div>
  </div>
</template>
<style>
#details a {
  text-decoration: none;
  color: black;
}
#details ul,
#details p,
#details h2,
#details h4,
#details h5,
#details h6 {
  list-style: none;
  text-align: center;
  font-weight: normal;
}

/*封装样式*/
.d-flex {
  display: flex;
  justify-content: space-between;
}
.colorbtn {
  color: white;outline: none;
}
.colorbtn:active{background: rgb(243, 185, 176);}
.color2 {
  color: tomato;
}
.bg1 {
  background-color: tomato;
  width: 32px;
  height: 18px;
}
.bg2 {
  width: 240px;
  height: 58px;
  background-color: tomato;
  outline: none;
  margin-right: 25px;
  border: 0;
}

.font1 {
  font-size: 12px !important;
  font-weight: normal;
}
.font2 {
  font-size: 14px;
}
.font3 {
  font-size: 16px;
}
.font4 {
  font-size: 18px;
}
.font5 {
  font-size: 20px;
}
.py {
  padding: 15px 0;
}
.paround {
  padding: 15px;
}
.py2 {
  padding: 20px 0 8px 0;
}
.pl1 {
  padding-left: 4px;
}
.mb {
  margin-bottom: 5px;
}

.my {
  margin: 10px 0;
}
.w-100 {
  width: 100%;
  border-bottom: 0.2px solid silver;
}
.w12 {
  width: 1200px;
  margin: 0 auto;
}

#details {
  background: white;
}
#details > .change {
  margin-top: 90px !important;
  height: 100%;
  width: 100%;
}

/* 轮播图 */
#details > .change .el-carousel__container {
  height: 520px !important;
  position: relative;
}
#details .change img {
  height: 100%;
  width: 100%;
}
#details .change .el-carousel__item h3 {
  color: #475669;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}

#details .change .el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

#details .change .el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}

.el-carousel__arrow:focus {
  outline: none;
}

/* 购买项 */
#buy-cont {
  width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
}
#buy-cont .buy-one,
#buy-cont .buy-two {
  flex-basis: 50%;
  box-sizing: border-box;
}
#buy-cont .buy-one {
  padding: 5px 10px;
  text-align: left;
}
.buy-one p,
.buy-one h4 {
  text-align: left;
}
.aha {
  position: relative;
}
.aha > .span1 {
  position: absolute;
  top: 5px;
  left: 207px;
  color: white !important;
}
.aha > .span2 {
  position: absolute;
  top: 5px;
  right: 43px;
  color: white !important;
}

.buy-two .el-tabs--border-card {
  border: 1px solid red;
  border-bottom: 0px;
  border-right: 0px;
}
.main,
.about {
  margin-bottom: 20px;
  height: 200px;
}
.main .left {
  float: left;
  margin-left: 350px;
}
.glass-img img {
  width: 200px;
}
</style>
<script>
import Glass from "../components/Glass.vue";
export default {
  components: { Glass },
  //接收cake创来的id参数
  props: ["Tid"],
  data() {
    return {
      carou: [
        { url: require("../../public/carousel/details2.jpg") },
        { url: require("../../public/carousel/details1.jpg") },
      ],
      detail: {},
      count: 0,
    };
  },
  methods: {
    getData() {
      // console.log(this.$router.query.tid)
      this.axios.get("/details", { params: { Tid: this.Tid } }).then((res) => {
        let data = res.data.results;
        this.detail = data;
      });
    },
    addCount(){
      if (this.$store.state.count === 9) {
      this.$message.error('亲,确定要购买这么多吗 ?')
      }
      this.$store.commit('changeCountTwo')
    },
    routerGo(){
      this.$router.push('/cart')
    }
  },
  mounted() {
    this.getData();
  },
};
</script>