<template>
  <v-layout row wrap pa-2>
    <v-flex xs3 pa-2 v-for="sticky in stickies">
      <v-card height="300" max-height="300" style="overflow: hidden;" :color="sticky.color" elevation="4">
        <v-container style="height: 250px;">
          <textarea v-model="sticky.text" style="width: 100%; height: 100%; resize: none;"></textarea>
        </v-container>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn icon @click.stop="remove(sticky)"><v-icon>close</v-icon></v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs3 pa-2>
      <v-card height="300" color="grey lighten-4" elevation="4" @click.native.stop="addSticky()">
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
        stickies: []
      };
    },
    methods: {
      clicked: function(sticky) {
      },
      remove: function(sticky) {
        this.stickies.splice(this.stickies.findIndex((element) => { return element.id == sticky.id }), 1)
      },
      addSticky: function() {
        var newId = -1;

        if (this.stickies.length > 0) {
          var lowestIdSticky = this.stickies.reduce((prev, curr) => {
            return prev.id < curr.id ? prev : curr;
          });

          var newId = lowestIdSticky.id;
          if (newId > 0)
            newId = -1;
          else
            newId -= 1;
        }

        this.stickies.push({ id: newId, text: '', color: 'yellow lighten-3'})
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