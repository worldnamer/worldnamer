import Vue from 'vue'
import Router from 'vue-router'
import { store } from './vuex/store'

import LandingPage from './components/LandingPage.vue'
import DashboardPage from './components/DashboardPage.vue'

Vue.use(Router);

export const router = new Router({
  mode: 'history',
  routes: [
    { path: '/', component: LandingPage },
    { path: '/dashboard', component: DashboardPage },

    // otherwise redirect to home
    { path: '*', redirect: LandingPage }
  ]
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = store.getters.loggedIn

  if (authRequired && !loggedIn) {
    return next('/');
  }

  next();
});
