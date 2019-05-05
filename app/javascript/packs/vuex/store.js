import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    sessionKey: null
  },
  getters: {
    loggedIn: (state) => {
      return state.sessionKey ? true : false;
    }
  },
  mutations: {
    logOut: (state) => {
      state.sessionKey = null;
    }
  },
  actions: {
  }
});
