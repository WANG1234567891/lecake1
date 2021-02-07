<template>
  <div id="homet-container">
    <el-container class="homet-container">
      <el-header>
        <el-button type="info" @click="logout">退出</el-button>
      </el-header>
      <el-container>
        <el-aside width="200px">Aside</el-aside>
        <el-main>Main</el-main>
      </el-container>
    </el-container>
  </div>
</template>
<script>
export default {
  methods: {
    logout() {
      window.sessionStorage.clear();
      this.$router.push("/login");
    },
  },
};
</script>
<style>
#homet-container{height: 100%;}
#homet-container .el-container{height: 600px;}
.el-header {
  background: #373d41;
}
.el-aside {
  background: #333744;
}
.el-main {
  background: #eaedf1;
}
</style>