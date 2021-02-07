import Vue from 'vue'
import VueRouter from 'vue-router'
//项目案例
import Home from '../views/Home.vue'
import Register from '../views/Register.vue';
import Login from '../views/Login.vue';
import Cake from '../views/Cake.vue';
import Oklist from '../views/Oklist.vue';
import OnePage from '../test/OnePage.vue';
import OkDetails from '../views/OkDetails.vue';
import Details from '../views/Details.vue';
import Index from '../test/Index.vue';
import Banner from '../test/Banner.vue';
import Carousel from "../test/Carousel.vue"
import Denglu from "../test/Denglu.vue"
import HomeT from "../test/HomeT.vue"



Vue.use(VueRouter)

const routes = [
    { path: '/', component: Home },
    { path: '/homet', component: HomeT },
    { path: '/register', component: Register },
    { path: '/login', component: Login },
    { path: '/cake', component: Cake },
    { path: '/oklist', component: Oklist },
    //通过路由传参，prop为允许组件传参
    { path: '/details/:Tid', props: true, component: Details },
    { path: '/okdetails/:Kid', props: true, component: OkDetails },


    // test
    { path: '/index', component: Index },
    { path: '/banner', component: Banner },
    { path: '/denglu', component: Denglu },
    {
        path: "/carousel",
        component: Carousel
    },
    {
        path: "/onepage",
        component: OnePage
    }
    // {
    //     path: '/about',
    //     name: 'About',
    //     // route level code-splitting
    //     // this generates a separate chunk (about.[hash].js) for this route
    //     // which is lazy-loaded when the route is visited.
    //     component: () =>
    //         import ( /* webpackChunkName: "about" */ '../views/About.vue')
    // }
]

const router = new VueRouter({
        mode: 'history',
        base: process.env.BASE_URL,
        routes
    })
    // router.beforeEach((to, from, next) => {
    //     if (to.path === "/login") return next()
    //     const tokenStr = window.sessionStorage.getItem('token')
    //     if (!tokenStr) return next("/login")
    //     next()
    // })
export default router