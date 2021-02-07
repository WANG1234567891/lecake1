<template>
  <div class="banner-container">
    <ul class="images">
      <li v-for="(item, i) of banners" :key="i" :class="{ on: i === index }">
        <a><img :src="item.url" alt="" /></a>
      </li>
    </ul>
    <ul class="dots">
      <li
        v-for="(item, i) in banners"
        :key="i"
        :class="{
          active: i === index,
        }"
        @click="index = i"
      ></li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Banner",
  //  props: {
  //    banners: {
  //      type: Array, //属性类型是数组
  //      required: true, //必须要传递该属性
  //    },
  //    duration: {
  //      type: Number,
  //      default: 2000, //属性默认值
  //    },
  //  },
  components: {},
  data() {
    return {
      index: 0, //当前显示的是第几张图片
      banners: [
        { url: require("../../public/carousel/lunbofour.jpg") },
        { url: require("../../public/carousel/lunboone.jpg") },
        { url: require("../../public/carousel/lunbofour.jpg") },
      ],
    };
  },
  methods: {
    // 自动开始切换
    autoStart() {
      setInterval(() => {
        this.index++;
        if (this.index > this.banners.length - 1) this.index = 0;
        // console.log(this.index,this.banners.length)
        // this.index = (this.index + 1) % this.banners.length;
        console.log(this.index);
      }, 3000);
    },
  },
  mounted() {
    this.autoStart();
  },
  watch: {},
  computed: {},
  filters: {},
};
</script>

<style scoped>
* {
  padding: 0;
  margin: 0;
}
.banner-container {
  height: 350px;
  position: relative;
  overflow: hidden;
}
.banner-container li {
  display: block;
  width: 1080px;
  height: 100%;
  float: left;
  position: absolute;
  right: 0;
  top: 0;
  opacity: 0;
  transition: all 0.5s ease;
}
.banner-container li.on {
  opacity: 1;
}
.images {
  height: 100%;
}
.banner-container img {
  width: 1080px;
  height: 100%;
}
.dots {
  position: absolute;
  bottom: 10px;
  right: 10px;
  display: flex;
}
.dots li {
  width: 10px;
  cursor: pointer;
  height: 10px;
  margin: 0 3px;
  border-radius: 50%;
  border: 1px solid;
  color: #fff;
  position: relative;
  opacity: 1;
}
.dots li.active {
  background: #fff;
  opacity: 1;
}
.banner-container[data-v-6803bba0] {
  width: 1080px;
  margin: 0 auto;
}
</style>
