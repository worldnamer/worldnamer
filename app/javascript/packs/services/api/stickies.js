import axios from 'axios'
import { store } from '../../vuex/store'

class StickiesAPI {
  static createSticky() {
    axios.post(StickiesAPI.resourceURL(), { headers: StickiesAPI.headers() })
      .then((response) => {
        store.state.stickies.push({ id: response.data.id, text: response.data.text, color: response.data.color })
      })
      .catch((response) => {
        console.log(response);
      });
  }

  static loadStickies() {
    axios.get(StickiesAPI.resourceURL(), { headers: StickiesAPI.headers() })
      .then((response) => {
        store.state.stickies = response.data
      })
      .catch((response) => {
        console.log(response);
      });
  }

  static updateSticky(sticky) {
    clearTimeout(store.state.timeout);
    store.state.timeout = setTimeout(() => {
      axios.put(StickiesAPI.resourceURL(sticky), { text: sticky.text, color: sticky.color, headers: StickiesAPI.headers() })
        .catch((response) => {
          console.log(response);
        });
    }, 500);
  }

  static deleteSticky(sticky) {
    store.state.stickies.splice(store.state.stickies.findIndex((element) => { return element.id == sticky.id }), 1)
    axios.delete(StickiesAPI.resourceURL(sticky), { headers: StickiesAPI.headers() })
      .catch((response) => {
        console.log(response);
      });
  }

  static resourceURL(resource) {
    if (resource) {
      return '/api/stickies/' + resource.id;
    } else {
      return '/api/stickies';
    }
  }

  static headers() {
    return {
      'Authorization': 'wnauth ' + store.state.sessionKey
    };
  }
}

export default StickiesAPI;