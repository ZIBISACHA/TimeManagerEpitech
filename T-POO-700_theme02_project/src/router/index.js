import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import TeamManager from '../components/TeamManager.vue'
import UserComponent from '../components/UserComponent.vue'
import UserTeamManager from '../components/UserTeamManager.vue'
import WorkingTime from '../components/WorkingTime.vue'
import WorkingTimes from '../components/WorkingTimes.vue'
import ClockComponent from '../components/ClockComponent.vue'
// import ChartContainer from '../components/ChartContainer.vue'
import AdminComponent from '../components/AdminComponent.vue'
import UserManagementComponent from '../components/UserManagementComponent.vue'
import SignUp from '../components/Authentication/SignUp.vue'
import Login from '../components/Authentication/Login.vue'
import ManagerCharts from '../components/Charts/ManagerCharts.vue'

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
    name: 'ManagerCharts',
    component: ManagerCharts,
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
  {
    path: '/register',
    name: 'SignUp',
    component: SignUp,
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/teams',
    name: 'team_management',
    component: TeamManager,
  },
  {
    path: '/teaminfo/:teamID',
    name: 'teaminfo_management',
    component: UserTeamManager,
  },
  {
    path: '/manager-charts',
    name: 'ManagerCharts',
    component: ManagerCharts,
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/login', '/register'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.user;
  console.log("Logged in? ", loggedIn);

  if (authRequired && !loggedIn) {
    return next('/login');
  } else {
    next();
  }
})

export default router
