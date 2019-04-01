import Vue from 'vue'
import Router from 'vue-router'

import LandingPage from '../components/LandingPage.vue'
import LoginPage from '../components/LoginPage.vue'

Vue.use(Router);

export const router = new Router({
  mode: 'history',
  routes: [
    { path: '/', component: LandingPage },
    { path: '/login', component: LoginPage },

    // otherwise redirect to home
    { path: '*', redirect: LandingPage }
  ]
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('user');

  if (authRequired && !loggedIn) {
    return next('/');
  }

  next();
});
