import "core-js/stable";
import "regenerator-runtime/runtime";

import Vue from 'vue'
import { store } from './vuex/store'
import { router } from './router'

Vue.router = router;

import Vuetify from 'vuetify'

import App from './components/App.vue'

import 'vuetify/dist/vuetify.min.css'
Vue.use(Vuetify)

import axios from 'axios'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    store,
    router,
    el: '#app'
  });
});
