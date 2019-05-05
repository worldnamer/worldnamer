import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    sessionKey: null
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
    }
  },
  mutations: {
    logOut: (state) => {
      sessionStorage.removeItem('sessionKey');
      state.sessionKey = null;
    }
  },
  actions: {
  }
});
