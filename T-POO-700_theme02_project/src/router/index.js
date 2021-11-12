import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import UserComponent from '../components/UserComponent.vue'
import WorkingTime from '../components/WorkingTime.vue'
import WorkingTimes from '../components/WorkingTimes.vue'
import ClockComponent from '../components/ClockComponent.vue'
import ChartContainer from '../components/ChartContainer.vue'
import AdminComponent from '../components/AdminComponent.vue'
import UserManagementComponent from '../components/UserManagementComponent.vue'
// import CurrentWeather from '../components/CurrentWeather.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'empty',
    component: Home
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  },
  {
    path: '/user/:id',
    name: 'userinfo',
    component: UserComponent,
    // props: {user_id: "1"}
  },
  {
    path: '/clock/:username',
    name: 'clockManager',
    component: ClockComponent,
  },
  {
    path: '/workingTime/:userID',
    name: 'workingTime',
    component: WorkingTime,
    props: true,
  },
  {
    path: '/workingTimes/:userID/all',
    name: 'workingTimes',
    component: WorkingTimes,
  },
  {
    path: '/workingTime/:userID/:workingtimeid',
    name: 'workingTimeModifier',
    component: WorkingTime,
    props: true,
  },
  {
    path: '/chart',
    name: 'chartManager',
    component: ChartContainer,
  },
  {
    path: '/admin',
    name: 'adminManager',
    component: AdminComponent,
  },
  {
    path: '/userinfo/:UserID',
    name: 'usermanagement',
    component: UserManagementComponent,
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
