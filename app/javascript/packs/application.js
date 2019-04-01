import Vue from 'vue'
import Vuetify from 'vuetify'
import Vuex from 'vuex'

import { router } from './router'
import { store } from './store'
import App from '../components/App.vue'

import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'));
  const app = new Vue({
    render: h => h(App),
    router,
    store,
    el: '#app'
  });
});
