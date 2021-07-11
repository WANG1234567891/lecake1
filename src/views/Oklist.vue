<template>
  <div id="oklist">
    <my-header></my-header>
    <div class="cakepro-container">
      <div><img src="../../public/cakepage/giftBanner_1013.jpg" alt="" /></div>
      <el-tabs
        v-model="activeName"
        @tab-click="handleClick"
        class="tabs"
        style=""
      >
        <el-tab-pane label="全部" name="1">
          <div class="cakelist">
            <div class="cake" v-for="(item, index) of cklist" :key="index">
              <div>
                <img :src="item.Kimg" alt="" />
                <!-- <glass :img="item.Kimg" :num="num"></glass> -->
              </div>
              <div>
                <p class="mt-mb oklist-ml">
                  <router-link to="/" class="color1">{{
                    item.Ktitle
                  }}</router-link>
                </p>
                <span class="font1 color3 bg1">{{ item.Ktitle_details }}</span>
                <p class="font1 color2 mb-1 oklist-ml">{{ item.Kgg }}</p>
                <p class="mb-0 oklist-ml">¥{{ item.Kprice }}</p>
                <p class="oklist-ml">
                  <router-link
                    :to="`/okdetails/${item.kid}`"
                    class="font1 color2"
                    >加入购物车+</router-link
                  >
                </p>
              </div>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="蛋糕" name="2">
          <div class="cakelist">
            <div class="cake" v-for="(item, index) of cklist2" :key="index">
              <div><img :src="item.Kimg" alt="" /></div>
              <div>
                <p class="mt-mb oklist-ml">
                  <router-link to="/" class="color1">{{
                    item.Ktitle
                  }}</router-link>
                </p>
                <span class="font1 color3 bg1">{{ item.Ktitle_details }}</span>
                <p class="font1 color2 mb-1 oklist-ml">{{ item.Kgg }}</p>
                <p class="mb-0 oklist-ml">¥{{ item.Kprice }}</p>
                <p class="oklist-ml">
                  <router-link
                    to="`/okdetails/${item.Kid}`"
                    class="font1 color2"
                    >加入购物车+</router-link
                  >
                </p>
              </div>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="面包" name="3">
          <div class="cakelist">
            <div class="cake" v-for="(item, index) of cklist3" :key="index">
              <div><img :src="item.Kimg" alt="" /></div>
              <div>
                <p class="mt-mb oklist-ml">
                  <router-link to="/" class="color1">{{
                    item.Ktitle
                  }}</router-link>
                </p>
                <span class="font1 color3 bg1">{{ item.Ktitle_details }}</span>
                <p class="font1 color2 mb-1 oklist-ml">{{ item.Kgg }}</p>
                <p class="mb-0 oklist-ml">¥{{ item.Kprice }}</p>
                <p class="oklist-ml">
                  <router-link
                    to="`/okdetails/${item.Kid}`"
                    class="font1 color2"
                    >加入购物车+</router-link
                  >
                </p>
              </div>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="吐司" name="4">
          <div class="cakelist">
            <div class="cake" v-for="(item, index) of cklist4" :key="index">
              <div><img :src="item.Kimg" alt="" /></div>
              <div>
                <p class="mt-mb oklist-ml">
                  <router-link to="/" class="color1">{{
                    item.Ktitle
                  }}</router-link>
                </p>
                <span class="font1 color3 bg1">{{ item.Ktitle_details }}</span>
                <p class="font1 color2 mb-1 oklist-ml">{{ item.Kgg }}</p>
                <p class="mb-0 oklist-ml">¥{{ item.Kprice }}</p>
                <p class="oklist-ml">
                  <router-link
                    to="`/okdetails/${item.Kid}`"
                    class="font1 color2"
                    >加入购物车+</router-link
                  >
                </p>
              </div>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="其他" name="5">
          <div class="cakelist">
            <div class="cake" v-for="(item, index) of cklist5" :key="index">
              <div><img :src="item.Kimg" alt="" /></div>
              <div>
                <p class="mt-mb">
                  <router-link to="/" class="color1">{{
                    item.Ktitle
                  }}</router-link>
                </p>
                <span class="font1 color3 bg1">{{ item.Ktitle_details }}</span>
                <p class="font1 color2 mb-1">{{ item.Kgg }}</p>
                <p class="mb-0">¥{{ item.Kprice }}</p>
                <!-- <p></p> -->
                <childOne style="postion:fixed;top:0;color:red;font-size:40px;z-index:999;" :num="num" />
                <p class="oklist-ml">
                  <router-link
                    to="`/okdetails/${item.Kid}`"
                    class="font1 color2"
                    >加入购物车+</router-link
                  >
                </p>
              </div>
            </div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
    <my-foot></my-foot>
  </div>
</template>
<style scoped>
#oklist .color1 {
  color: black !important;
  text-decoration: none;
}
a:hover {
  color: tomato;
}
a {
  text-decoration: none;
}
.color2 {
  color: tomato !important;
}
.font1 {
  font-size: 12px;
}
.color3 {
  color: #949494;
}
.bg1 {
  background: #cca976;
  padding: 1px 6px;
  width: 137px;
  color: white;
}
.oklist-ml {
  margin: 0.7rem 0;
}
.tabs {
  background: white;
  width: 1200px;
  margin: 0 auto;
  margin-top: 15px;
  padding: 20px 30px;
}
/* 商品容器 */
.cakepro-container {
  width: 1200px;
  box-sizing: border-box;
  padding: 20px 0 30px 0;
  position: absolute;
  top: 10%;
  left: 16%;
  font-size: 14px;
}
.cakepro-container .cakelist {
  clear: both;
  width: 1200px;
  box-sizing: border-box;
}
.cakepro-container .cake {
  box-sizing: border-box;
  width: 300px;
  height: 430px;
  padding: 20px;
  background: white;
  border: 1.5px solid #f9f9f9;
  float: left;
}
.cakepro-container .cake div:first-child {
  width: 260px;
  height: 260px;
  overflow: hidden;
  margin-bottom: 15px;
}
.cakepro-container .cake img {
  width: 260px;
  height: 260px;
  transition: all 0.3s linear;
}
.cakepro-container .cake:hover img {
  transform: scale(1.2, 1.2);
}
/* 底部关于 */
#footer[data-v-1ef6d16a] {
  margin-top: 1845px;
}
</style>
<script>
import Glass from "../components/Glass.vue";
import childOne from "./gg.vue";
export default {
  components: { Glass, childOne },
  data() {
    return {
      num: 520,
      activeName: "1",
      cklist: [],
      cklist2: [],
      cklist3: [],
      cklist4: [],
      cklist5: [],
    };
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    },
  },
  mounted() {
    this.axios.get("/Oklist").then((result) => {
      let res = result.data.results;
      this.cklist = res;
      console.log(this.cklist);
      res.forEach((el) => {
        if (el.Kindle == "蛋糕") {
          this.cklist2.push(el);
        } else if (el.Kindle == "面包") {
          this.cklist3.push(el);
        } else if (el.Kindle == "吐司") {
          this.cklist4.push(el);
        } else {
          this.cklist5.push(el);
        }
      });
    });
  },
};
</script>