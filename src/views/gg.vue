<template>
     <div>配置跨域页面</div>
</template>
<script>
export default {
     mounted(){
       console.log(this.axios.get("/try.php?filename=tryjquery_hide").then(results =>{console.log(results)}))
     }
}
</script>