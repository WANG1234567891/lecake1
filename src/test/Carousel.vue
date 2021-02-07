<template>
  <div class="carousel-container">
    <!-- <ul class="imgs">
      <li v-for="(it, i) of banners" :key="i" :class="{ do: i == index }">
        <a href=""><img :src="it.url" alt="" /></a>
      </li>
    </ul>
    <ul class="circle">
      <li
        v-for="(it, i) of banners"
        :key="i"
        :class="{ active: i == index }"
        @click="index = i"
      ></li>
    </ul> -->

    
    <ul class="imgs">
      <li v-for="(item,inde) of banners" :key="inde" :class="{do:inde == index}">
        <a href=""><img :src="item.url" alt=""></a>
      </li>
    </ul>
    <ul class="circle">
      <li v-for="(item,i) of banners" :key="i" :class="{active:i == index}" @click="index = i"></li>
    </ul>

    <div>{{this.$route.params.id}}</div>
  </div>
</template>
<style scoped>
* {
  margin: 0;
  padding: 0;
}
.carousel-container {
  height: 360px;
  width: 1080px;
  margin: 0 auto;
  position: relative;
  overflow: hidden;
}
.carousel-container li {
  display: block;
  width: 1080px;
  height: 100%;
  float: left;
  position: absolute;
  left: 0;
  top: 0;
  opacity: 0;
  transition: all 1s linear;
}
.carousel-container li.do {
  opacity: 1;
}
.imgs {
  height: 100%;
}
.imgs img {
  width: 100%;
  height: 100%;
}
.circle {
  position: absolute;
  bottom: 10px;
  left: 10px;
  width: 100%;
  height: 12px;
  display: flex;
  transform: translate(50%);
}
.circle li {
  width: 10px;
  cursor: pointer;
  height: 10px;
  border-radius: 50%;
  border: 1px solid white;
  opacity: 1;
  margin: 0 5px;
  position: relative;
}
.circle li.active {
  background: tomato;
}
</style>

<script>
export default {
  // data() {
  //   return {
  //     index: 0,
  //     banners: [
  //       { url: require("../../public/carousel/lunbofour.jpg") },
  //       { url: require("../../public/carousel/lunboone.jpg") },
  //       { url: require("../../public/carousel/lunbofour.jpg") },
  //     ],

  //   };
  // },
  // methods:{
  //      autoLoad(){
  //           setInterval(() => {
  //                this.index +=1;
  //                if(this.index > this.banners.length-1)
  //                this.index =0
  //           }, 3000);
  //      }
  // },
  // mounted(){
  //      this.autoLoad()
  // }

  data() {
    return {
      index: 0,
      banners: [
        { url: require("../../public/carousel/lunbofour.jpg") },
        { url: require("../../public/carousel/lunboone.jpg") },
        { url: require("../../public/carousel/lunbothree.jpg") },
      ],

    };
  },
  methods:{
    autoLoad(){
      setInterval(() => {
        this.index +=1;
        if(this.index > this.banners.length-1)
        this.index =0;
      }, 3000);
    }
  },
  mounted(){
    this.autoLoad()
  }
};
</script>