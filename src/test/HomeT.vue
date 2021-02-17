<template>
  <div id="homet-container">
    <el-container class="homet-container">
      <el-header>
        <div>
          <img src="../assets/homet/logo.jpg" alt="" /><span>电商管理后台</span>
        </div>
        <el-button type="info" @click="logout">退出</el-button>
      </el-header>
      <el-container>
        <el-aside :width="isCollapse ? '64px' : '200px'">
          <div class="toggle-button" @click="toggleCollapse">|||</div>
          <el-menu
            background-color="#333744"
            text-color="#fff"
            active-text-color="#0aa1ed"
            unique-opened
            :collapse="isCollapse"
            :collapse-transition="false"
            router
            :default-active="activePath">
            <el-submenu
              :index="item.id + ''"
              v-for="item in menulist"
              :key="item.id">
              <template slot="title">
                <i :class="icons[item.id]"></i>
                <span>{{ item.authName }}</span>
              </template>
              <el-menu-item
                :index="'/' + subitem.path"
                v-for="subitem in item.children"
                :key="subitem.id"
                @click="saveNavState('/' + subitem.path)">
                <template slot="title">
                  <i class="el-icon-menu"></i>
                  <span>{{ subitem.authName }}</span>
                </template>
              </el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      menulist: [],
      icons: {
        1: "el-icon-user-solid",
        2: "el-icon-s-management",
        3: "el-icon-s-cooperation",
        4: "el-icon-s-order",
        5: "el-icon-s-data",
      },
      // 是否折叠
      isCollapse: false,
      // 被激活的链接地址
      activePath: "",
    };
  },
  created() {
    this.getMenuList();
    this.activePath = window.sessionStorage.getItem("activePath");
  },
  methods: {
    logout() {
      window.sessionStorage.clear();
      this.$router.push("/denglu");
    },
    async getMenuList() {
      const { data: res } = await this.axios.get("/menulist");
      console.log(res);
      if (res.meta.status !== 200) return this.$messsage.error("获取数据失败");
      this.menulist = res.data;
    },
    toggleCollapse() {
      this.isCollapse = !this.isCollapse;
    },
    saveNavState(activePath) {
      window.sessionStorage.setItem("activePath", activePath);
      this.activePath = activePath;
    },
  },
};
</script>

<style scoped>
#homet-container {
  width: 70%;
  height: 100%;
  margin: 0 auto;
  color: white;
}
#homet-container .el-container {
  height: 600px;
}
.el-header {
  background: #373d41;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 20px;
}
.el-header > div {
  display: flex;
  align-items: center;
}
.el-header > div img {
  width: 50px;
  height: 50px;
}
.el-header > div span {
  padding-left: 20px;
}
.el-aside {
  background: #333744;
  -webkit-user-select: none;
}
.el-main {
  background: #eaedf1;
  color: black;
}
.el-submenu [class^="el-icon-"] {
  margin-right: 12px;
}
.el-menu {
  border-right: none;
}
.toggle-button {
  background: #333744;
  text-align: center;
  font-size: 12px;
  color: white;
  letter-spacing: 0.1em;
  line-height: 20px;
}
.el-submenu__title * {
  vertical-align: top;
}
</style>

