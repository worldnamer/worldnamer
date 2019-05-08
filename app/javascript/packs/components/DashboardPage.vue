<template>
  <v-layout row wrap pa-2>
    <v-flex xs3 pa-2 v-for="sticky in stickies">
      <v-card height="300" max-height="300" style="overflow: hidden;" :color="sticky.color" elevation="4">
        <v-container style="height: 250px;">
          <textarea v-model="sticky.text" style="width: 100%; height: 100%; resize: none;" v-on:keyup="onKeyUp($event, sticky)"></textarea>
        </v-container>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn icon @click.stop="remove(sticky)"><v-icon>close</v-icon></v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs3 pa-2>
      <v-card height="300" color="grey lighten-4" elevation="4" @click.stop="addSticky">
        <v-layout align-center justify-center fill-height>
          <v-btn icon><v-icon>add_box</v-icon></v-btn>
        </v-layout>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default {
    data: function () {
      return {
        stickies: [],
        timeout: null
      };
    },
    methods: {
      clicked: function(sticky) {
      },
      remove: function(sticky) {
        this.stickies.splice(this.stickies.findIndex((element) => { return element.id == sticky.id }), 1)
        this.axios.delete('/api/stickies/' + sticky.id, { headers: { 'Authorization': 'wnauth ' + this.$store.state.sessionKey } })
          .catch((response) => {
            console.log(response);
          });
      },
      addSticky: function() {
        this.axios.post('/api/stickies', { headers: { 'Authorization': 'wnauth ' + this.$store.state.sessionKey } })
          .then((response) => {
            this.stickies.push({ id: response.data.id, text: response.data.text, color: response.data.color })
          })
          .catch((response) => {
            console.log(response);
          });
      },
      onKeyUp: function(event, sticky) {
        clearTimeout(self.timeout);
        self.timeout = setTimeout(() => { 
          this.axios.put('/api/stickies/' + sticky.id, { text: sticky.text, color: sticky.color, headers: { 'Authorization': 'wnauth ' + this.$store.state.sessionKey } })
            .catch((response) => {
              console.log(response);
            });
        }, 500);
      }
    },
    mounted: function() {
      this.axios.get('/api/stickies', { headers: { 'Authorization': 'wnauth ' + this.$store.state.sessionKey } })
        .then((response) => {
          this.stickies = response.data
        })
        .catch((response) => {
          console.log(response);
        });
    }
  }
</script>