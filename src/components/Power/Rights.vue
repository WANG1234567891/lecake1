<template>
  <div>
    <!-- 导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>权限列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 卡片视图 -->
    <el-card>
         <el-table :data="rightsList" border stripe>
              <el-table-column label="#" type="index"></el-table-column>
              <el-table-column label="路径" prop="authName"></el-table-column>
              <el-table-column label="路径" prop="path"></el-table-column>
              <el-table-column label="路径" prop="level">
                   <template slot-scope="scope">
                        <el-tag v-if="scope.row.level == '2'">一级</el-tag>
                        <el-tag type="success" v-else-if="scope.row.level == '4'">二级</el-tag>
                        <el-tag type="warning" v-else>三级</el-tag>
                   </template>
              </el-table-column>
         </el-table>
    </el-card>
  </div>
</template>
<style scoped>
.el-breadcrumb {
  margin-bottom: 15px;
  font-size: 12px;
}
</style>
<script>
export default {
  data() {
    return {
      rightsList: [],
    };
  },
  created() {
    this.getRightsList();
  },
  methods: {
    async getRightsList() {
      const { data: res } = await this.axios.get("/rights/list");
      if (res.status !== 200) return this.$message.error("获取权限列表失败");
      this.rightsList = res.data;
     //  console.log(res.data)
    },
  },
};
</script>