<template>
  <div id="app">
    <router-view />
    <div ref="scrollRef" class="scrollT" @click="scrollTop" style="display:none;">↑</div>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
* {
  margin: 0;
  padding: 0;
}
body {
  background-color: #ebebeb;
}

.scrollT {
  width: 50px;
  height: 50px;
  background: rgb(241, 6, 6);
  color: white;
  position: fixed;
  bottom: 300px;
  right: 50px;
  font-size: 25px;
  text-align: center;
  line-height: 50px;
  z-index: 300;cursor: pointer;
}
</style>
<script>
export default {
  data() {
    return{};
  },
  methods: {
    // 滚动条置顶
    scrollTop() {
      let timer, speed, scrollPostion;
      speed = 20;
      scrollPostion =
        document.documentElement.scrollTop || document.body.scrollTop;
      timer = setInterval(() => {
        if (scrollPostion > 0) {
          scrollPostion -= speed;
          window.scrollTo(0, scrollPostion);
        } else {
          window.scrollTo(0, 0);
          clearInterval(timer);
        }
      }, 1);
    },
  },
  mounted(){
    let scrollT=this.$refs.scrollRef
    // console.log(scrollT)
    document.body.onscroll=function(){
      if(document.documentElement.scrollTop > 150){
        scrollT.style.display='block'
      }else{
        scrollT.style.display='none'
      }
    }

  }
};
</script>
