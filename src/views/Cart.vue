<template>
  <div id="cart">
    <my-header></my-header>
    <el-table :data="items" height="100%" border style="width: 100%">
          <el-table-column type="index" label="#" > </el-table-column>
          <el-table-column label="图片" width="80">
               <img src="../../public/cake/1.jpg" alt="" style="width:50px;height:50px;"/>
          </el-table-column>
          <el-table-column prop="name" label="商品名称" width="180"> </el-table-column>
          <el-table-column label="商品数量" width="202">
               <template slot-scope="scope">
                    <el-input-number v-model="scope.row.count" @change="addCount" @keyup.enter.native="addCount" :min="1" :max="10" ref="inpRef"></el-input-number>
               </template>
          </el-table-column>
          <el-table-column label="商品单价" width="180">
               <template slot-scope="scope">{{scope.row.price.toFixed(2)}}</template>
          </el-table-column>
          <el-table-column label="商品小计" width="180">
               <template slot-scope="scope">{{scope.row.price * scope.row.count | priceFilter}}</template>
          </el-table-column>
          <el-table-column prop="address" label="下单地址"> </el-table-column>
          <el-table-column prop="date" label="下单日期" width="180"> </el-table-column>
     </el-table>
    <el-card>您选择的数量总计是: {{totalCount}} 价格共计 :{{totalPrice.toFixed(2)}} </el-card>
    <!-- <p>{{this.$store.state.count}}</p>
    <p>{{this.$store.state.age}}</p>
    <p>{{this.$store.state.username}}</p>
    <p>{{this.$store.state.sex ? "男" : "女"}}</p>
    <ul>
         <li v-for="(item,index) of this.$store.state.products" :key="index">{{ item.productName }} {{ item.productPrice }}</li>
    </ul>
    <mt-field type="text" label="商品名称" v-model="productName" placeholder="请输入商品名称"></mt-field>
    <mt-field type="text" label="商品价格" v-model="productPrice" placeholder="请输入商品价格"></mt-field>
    <mt-button @click="addPro">添加</mt-button> 
    <mt-button @click="getPro">获取</mt-button> 
    <hr>

    <div class="inner-container">
         <p class="text" v-for="(text,index) in arr" :key="index">{{text}}</p>
    </div> -->
  </div>
</template>

<script>
import MyHeader from "../components/MyHeader";

export default {
  components: { MyHeader },
  data() {
    return {
      productName:"",
      productPrice:null,
      arr:[
           'hello',
           '抓住！草莓季の尾巴',
           '2 人间极品',
           '3 欢乐无极限',
           '4 现在还不动手',
           '5 机会错过不再有'
      ],
      items: [
        {
          date: "2016-05-03",
          name: "雪域牛乳芝士",
          address: "上海市普陀区金沙江路 1518 弄",
          price:79,
          count:1,
        },
     //    {
     //      date: "2016-05-02",
     //      name: "雪域燕麦芝士·轻享",
     //      address: "上海市普陀区金沙江路 1518 弄",
     //      price:180.8,
     //      count:3,
     //    },
     //    {
     //      date: "2016-05-04",
     //      name: "巴斯克流心",
     //      address: "上海市普陀区金沙江路 1518 弄",
     //      price:280.99,
     //      count:1,
     //    },
     //    {
     //      date: "2016-05-01",
     //      name: "壁咚！阿华田",
     //      address: "上海市普陀区金沙江路 1518 弄",
     //      price:380,
     //      count:1,
     //    },
        
      ],
    };
  },
  methods:{
       addCount(val){
            console.log(val)
            this.$store.commit("changeCount",val)
       },
       addPro(){
            let obj={productName:this.productName,productPrice:this.productPrice}
            this.$store.commit('addProduct',obj)
            this.productPrice = null
            this.productName = ''
       },
       getPro(){
            this.$store.dispatch("getServerData")
       }
  },
  computed:{
      totalCount:function(){
           let n=0
           this.items.forEach((item,index)=> {
                n +=item.count 
           });
           return n
      },
      totalPrice:function(){
           let total=0
           this.items.forEach((item,index)=>{
                total +=item.count *item.price
           })
           return total
      }
  }
};
</script>

<style scoped>
.el-table {
  margin-top: 6rem;
}
.el-card{text-align: center;margin-top: 1rem;}
.cart-ul{width: 100%;height: 3rem;}

.inner-container{overflow: hidden;
     position: fixed;width: 140px;
     height: 30px;
     border: 1px solid red;
     top: 400px;left: 80px;
}
.text{     
     animation: myMove 5s linear infinite;
     text-align: center;
     line-height: 38px;
     width: 100%;height: 100%;
     animation-fill-mode: forwards;
     font-size: 14px;
     font-weight: bold;
}
/*文字停顿滚动*/
@keyframes myMove {
  0% {
    transform: translateY(0);
  }
  10% {
    transform: translateY(-28px);
  }
  20% {
    transform: translateY(-28px);
  }
  30% {
    transform: translateY(-60px);
  }
  40% {
    transform: translateY(-60px);
  }
  50% {
    transform: translateY(-90px);
  }
  60% {
    transform: translateY(-90px);
  }
  70% {
    transform: translateY(-120px);
  }
  80% {
    transform: translateY(-120px);
  }
  90% {
    transform: translateY(-150px);
  }
  100% {
    transform: translateY(-150px);
  }
}
</style>