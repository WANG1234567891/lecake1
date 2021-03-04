<template>
     <div>
        <!-- 导航 -->
        <el-breadcrumb separator-class="el-icon-arrow-right">
          <el-breadcrumb-item :to="{ path: '/homet' }">首页</el-breadcrumb-item>
          <el-breadcrumb-item>订单管理</el-breadcrumb-item>
          <el-breadcrumb-item>订单列表</el-breadcrumb-item>
        </el-breadcrumb>
        <!-- 卡片视图区域 -->
        <el-card>
          <el-row>
            <el-col :span="9">
              <el-input placeholder="请输入内容" v-model="input3" >
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </el-col>
          </el-row>
          <!-- 表格区域 -->
          <el-table :data="orderList" border stripe>
                <el-table-column type="index" label="#" width="30"></el-table-column>
                <el-table-column prop="order_number" label="订单编号" width="180"></el-table-column>
                <el-table-column prop="order_price" label="订单价格" width="80"></el-table-column>
                <el-table-column prop="order_pay" label="是否付款" width="80">
                  <template slot-scope="scope">
                    <el-tag type="success" v-if="scope.row.order_pay == '1' ">已付款</el-tag>
                    <el-tag type="danger" v-else>未付款</el-tag>
                  </template>
                </el-table-column>
                <el-table-column prop="is_send" label="是否发货" width="80"></el-table-column>
                <el-table-column prop="create_time" label="下单时间" width="100">
                  <template slot-scope="scope">{{scope.row.create_time | dataFormat}}</template>
                </el-table-column>
                <el-table-column label="操作">
                  <template slot-scope="scope">
                    <el-button type="primary" size="mini" class="el-icon-edit" @click="showBox"></el-button>
                    <el-button type="success" size="mini" class="el-icon-location" @click="showProgressBox"></el-button>
                  </template>
                </el-table-column>
          </el-table>
          <!-- 分页区域 -->
          <el-pagination
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="queryInfo.pageNum"
            :page-sizes="[5, 10, 15]"
            :page-size="queryInfo.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
          </el-pagination>
          <el-dialog
              title="修改地址"
              :visible.sync="addressVisible"
              width="50%" @close="addressDialogClose">
              <el-form :model="addressFrom" :rules="addressFromRule" ref="addressFromRef" label-width="100px">
                  <el-form-item label="省市区/县" prop="address1">
                    <el-cascader :options="cityData" v-model="addressFrom.address1"></el-cascader>
                  </el-form-item>
                  <el-form-item label="详细地址" prop="address2">
                    <el-input v-model="addressFrom.address2"></el-input>
                  </el-form-item>
              </el-form>
              <span slot="footer" class="dialog-footer">
                <el-button @click="addressVisible = false">取 消</el-button>
                <el-button type="primary" >确 定</el-button>
              </span>
          </el-dialog>
          <el-dialog title="物流进度" :visible.sync="progressVisible"  width="50%">
                <el-timeline>
                  <el-timeline-item
                    v-for="(activity, index) in progressInfo"
                    :key="index"
                    :timestamp="activity.time">
                    {{activity.content}}
                  </el-timeline-item>
                </el-timeline>
          </el-dialog>
        </el-card>
     </div>
</template>

<script>
export default {
  data() {
    return {
      input3:'',
      num:8848,
      queryInfo:{
        query:'',
        pageNum:1,
        pageSize:10
      },
      addressFrom:{
        address1:[],
        address2:''
      },
      progressInfo:[],
      total:0,
      orderList:[],
      addressVisible:false,
      progressVisible:false,
      cityData:[],
      addressFromRule:{
        address1:[{ required: true, message: '请选择省市区/县', trigger: 'blur' },],
        address2:[{ required: true, message: '请填写详细地址', trigger: 'blur' },]
      }
    };
  },
  methods: {
    async  getOrderList(){
      const {data:res} = await this.axios.get("/order",{params:this.queryInfo})
      if(res.status !== 200){
        return this.$message.error("数据获取失败！")
      }
      this.$message.success("ok")
      this.orderList=res.data.goods
      this.total=res.total
      this.cityData=res.result
    },
    handleSizeChange(newSize){
      console.log(newSize)
      this.getOrderList()

    },
    handleCurrentChange(newPage){
      console.log(newPage)
      this.getOrderList()
    },
    showBox(){
      this.addressVisible = true
    },
    addressDialogClose(){
      this.$refs.addressFromRef.resetFields()
    },
    async showProgressBox(){
      
      const {data:res} = await this.axios.get(`/kuaidi/8848`)
      if(res.status !==200){
        return this.$message.error("失败！")
      }
      this.progressVisible = true
      this.$message.success("oks")
      this.progressInfo = res.data
    }
    
  },
  created() {
    this.getOrderList()
  }
};
</script>

<style scoped>
.el-breadcrumb{
     margin-bottom: 15px;
     font-size: 12px;
}
.el-row{margin-bottom:1rem;}
.el-button{outline: none;}
.el-pagination{margin-top: .4rem;}
</style>