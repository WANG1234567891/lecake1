import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {
        isLogined: 0,
        username: "bob",
        age: 22,
        // ture男 false女
        sex: true,
        products: [
            { productName: "长虹", productPrice: 4000 },
            { productName: "海尔", productPrice: 3000 },
            { productName: "冰岛", productPrice: 2000 },
            { productName: "创维", productPrice: 3300 }
        ]

    },
    //来修改state中的共享状态时的操作方法
    mutations: {
        //state代表的是当前store中所有的state
        //在提交mutations时，无需注入参数，会自动注入
        changeAge(state) {
            state.age++;
        },
        //payload为输入框输入的数据
        upProduct(state, payload) {
            state.products.push(payload)
        },
        //修改登录状态为1
        login_mutations(state) {
            state.isLogined = 1;
        }
    },
    actions: {},
    modules: {}
})