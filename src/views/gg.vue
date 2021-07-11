<template>
  <div>
    配置跨域页面
    <h5>{{ num }}</h5>
  </div>
</template>
<script>
import { number } from 'echarts';
export default {
     props:{num:{type:Number}},
  data() {
    return {  };
  },
  mounted() {
//     console.log(
//       this.axios.get("/try.php?filename=tryjquery_hide").then((results) => {
//         console.log(results);
//       })
//     );
  },
};
</script>