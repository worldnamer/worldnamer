import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'

import { router } from './router'
import { store } from './store'
import App from '../components/App.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'));
  const app = new Vue({
    render: h => h(App),
    router,
    store,
    el: '#app'
  });
});
