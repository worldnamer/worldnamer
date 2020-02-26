import Vue from 'vue'
import Router from 'vue-router'
import { store } from './vuex/store'

import LandingPage from './components/LandingPage.vue'
import DashboardPage from './components/DashboardPage.vue'
import ProjectsPage from './components/ProjectsPage.vue'

Vue.use(Router);

export const router = new Router({
  mode: 'history',
  routes: [
    { path: '/', component: LandingPage },
    { path: '/dashboard', component: DashboardPage },
    { path: '/projects', component: ProjectsPage },

    // otherwise redirect to home
    { path: '*', redirect: LandingPage }
  ]
});

router.beforeEach((to, from, next) => {
  // redirect to login page if not logged in and trying to access a restricted page
  const publicPages = ['/'];
  const onLandingPage = publicPages.includes(to.path);
  const loggedIn = store.getters.loggedIn

  if (onLandingPage && loggedIn) {
    next('/dashboard');
  } else if (!onLandingPage && !loggedIn) {
    next('/');
  } else {
    next();
  }
});
