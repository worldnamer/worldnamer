import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

import axios from 'axios'

import StickiesAPI from '../services/api/stickies'

export const store = new Vuex.Store({
  state: {
    sessionKey: null,
    stickies: [],
    timeout: null
  },
  getters: {
    loggedIn: (state) => {
      if (state.sessionKey) {
        return true;
      } else {
        state.sessionKey = sessionStorage.getItem('sessionKey');
        if (state.sessionKey) {
          // JWLL: need to check token after rehydrating, instead of assuming it's good
          return true;
        }

        return false;
      }
    },
  },
  mutations: {
    logOut: (state) => {
      sessionStorage.removeItem('sessionKey');
      state.sessionKey = null;
    },
    logIn: (state, password) => {
      axios.post('/api/sessions', { headers: { 'Authorization': 'Basic ' + btoa('worldnamer:' + password) } })
        .then((response) => {
          sessionStorage.setItem('sessionKey', response.data.key);
          state.sessionKey = response.data.key;
          Vue.router.push('/dashboard');
        })
        .catch((response) => {
          console.log(response);
        });
    },

    loadStickies: (state) => {
      StickiesAPI.loadStickies();
    },
    addSticky: (state) => {
      StickiesAPI.createSticky();
    },
    removeSticky: (state, sticky) => {
      StickiesAPI.deleteSticky(sticky);
    },
    updateSticky: (state, sticky) => {
      StickiesAPI.updateSticky(sticky);
    }
  },
  actions: {
  }
});
