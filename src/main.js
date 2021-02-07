import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import qs from 'qs'

import Moment from 'moment'
import Glass from './components/Glass.vue'
Vue.use(Moment)
    //导入mint UI 的所有组件
import MintUI from 'mint-ui';
//导入mintui的样式文件
import 'mint-ui/lib/style.min.css';
//导入通过vue.use方法将mint ui 注册为vue的插件
Vue.use(MintUI);
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI)
import MyHeader from './components/MyHeader'
import MyFoot from './components/MyFoot'
Vue.component("my-header", MyHeader)
Vue.component("my-foot", MyFoot)
Vue.component("glass", Glass)

axios.defaults.baseURL = 'http://127.0.0.1:3000'
Vue.prototype.moment = Moment
Vue.prototype.axios = axios;
Vue.prototype.qs = qs;
Vue.config.productionTip = false

new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app')