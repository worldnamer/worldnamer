import Vue from 'vue'
import { store } from './vuex/store'
import { router } from './router'

import Vuetify from 'vuetify'

import App from './components/App.vue'

import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    store,
    router,
    el: '#app'
  });
});
