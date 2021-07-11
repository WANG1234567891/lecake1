import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from '../router/index'
import { Message } from 'element-ui';
Vue.use(Vuex)
axios.defaults.baseURL = '/api'
export default new Vuex.Store({
    state: {
        isLogined: localStorage.getItem('isLoinged') || 0,
        userInfo: JSON.parse(localStorage.getItem('userInfo')) || {},
        age: 22,
        // ture男 false女
        sex: true,
        products: [
            { productName: "长虹", productPrice: 4000 },
            { productName: "海尔", productPrice: 3000 },
            { productName: "冰岛", productPrice: 2000 },
            { productName: "创维", productPrice: 3300 }
        ],
        count: 0

    },
    //来修改state中的共享状态时的操作方法
    mutations: {
        //state代表的是当前store中所有的state
        //在提交mutations时，无需注入参数，会自动注入
        changeAge(state) {
            state.age++;
        },
        //pro为输入框输入的数据
        upProduct(state, payload) {
            state.products.push(payload)
        },
        //修改登录状态为1,用户的相关信息
        login_mutations(state, userMessage) {
            state.isLogined = 1;
            state.userInfo = userMessage
            console.log(userMessage)
        },
        logOut_mutation(state) {
            state.userInfo = {}
            this.state.isLogined = 0
            localStorage.clear()

        },
        changeCount(state, val) {
            state.count = val
            console.log(val)
        },
        changeCountTwo(state) {
            this.state.count++
        },
        addProduct(state, pro) {
            // console.log(pro)
            state.products.push(pro)
        }
    },
    actions: {
        async getServerData(context) {
            // context当前所有的store的属性
            console.log(context)
            const { data: res } = await axios.get('/data')
            context.commit('addProduct', res.results[0])
        },
        login_actions(context, payload) {
            // console.log(context, payload)
            console.log(this)
            axios.post('/login', payload).then(res => {
                console.log(res)
                if (res.data.code == 1) {
                    Message.success('登陆成功Welcome here!')
                    context.commit('login_mutations', res.data.userInfo)
                        // 将用户的状态信息保存到本地
                    localStorage.setItem('isLoinged', 1)
                    localStorage.setItem('userInfo', JSON.stringify(res.data.userInfo))
                    router.push("/").catch(err => err);
                } else {
                    // (this.username = ""),
                    // (this.password = ""),
                    Message.error('登录失败！')
                    router.push("/login");
                }
            })
        }
    },
    modules: {}
})