import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import "./assets/css/reset.css"
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

import TreeTable from 'vue-table-with-tree-grid'
Vue.component("tree-table", TreeTable)

import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css' // import styles
import 'quill/dist/quill.snow.css' // for snow theme
import 'quill/dist/quill.bubble.css' // for bubble theme

Vue.use(VueQuillEditor)
    // 引入jq的配置1
import $ from "jquery"

// 日期格式化过滤器
Vue.filter('dataFormat', function(originVal) {
    const dt = new Date(originVal)
    const y = dt.getFullYear()
    const m = (dt.getMonth() + 1 + '').padStart(2, '0')
    const d = (dt.getDate() + '').padStart(2, '0')
    const hh = (dt.getHours() + '').padStart(2, '0')
    const mm = (dt.getMinutes() + '').padStart(2, '0')
    const ss = (dt.getSeconds() + '').padStart(2, '0')
    return `${ y }-${ m }-${ d } ${ hh }:${ mm }:${ ss }`

})

import MyHeader from './components/MyHeader'
import MyFoot from './components/MyFoot'
Vue.component("my-header", MyHeader)
Vue.component("my-foot", MyFoot)
Vue.component("glass", Glass)
    // 跨域代理
axios.defaults.baseURL = '/api'
    // axios.defaults.baseURL = 'http://127.0.0.1:3000'
axios.interceptors.request.use(config => {
    console.log(config)
    config.headers.Authorization = window.sessionStorage.getItem("token")
    return config
})
Vue.prototype.moment = Moment
Vue.prototype.axios = axios;
Vue.prototype.qs = qs;
Vue.config.productionTip = false

new Vue({
    router,
    store,
    // 引入jq的配置2
    $,
    render: h => h(App)
}).$mount('#app')