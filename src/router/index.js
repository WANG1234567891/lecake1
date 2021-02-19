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
import Gg from '../views/gg.vue';


import Index from '../test/Index.vue';
import Banner from '../test/Banner.vue';
import Carousel from "../test/Carousel.vue"
import Denglu from "../test/Denglu.vue"
import HomeT from "../test/HomeT.vue"
import Welcome from "../components/Welcome.vue"
import Users from "../components/Users.vue"
import Rights from "../components/Power/Rights.vue"
import Userlist from "../components/Power/Userlist.vue"

Vue.use(VueRouter)

const routes = [
    { path: '/', component: Home },
    { path: '/gg', component: Gg },
    {
        path: '/homet',
        component: HomeT,
        redirect: '/welcome',
        children: [{
                path: '/welcome',
                component: Welcome
            },
            {
                path: '/users',
                component: Users
            },
            {
                path: "/Rights",
                component: Rights
            }, {
                path: "/userlist",
                component: Userlist
            }
        ]
    },
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
    // 懒加载配置
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