<template>
  <v-layout row wrap pa-2>
    <v-flex xs3 pa-2 v-for="sticky in stickies">
      <v-card height="300" max-height="300" style="overflow: hidden;" :color="sticky.color" elevation="4">
        <v-container style="height: 250px;">
          <textarea v-model="sticky.text" style="width: 100%; height: 100%; resize: none;" v-on:keyup="$store.commit('updateSticky', sticky)"></textarea>
        </v-container>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn icon @click.stop="$store.commit('removeSticky', sticky)"><v-icon>close</v-icon></v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
    <v-flex xs3 pa-2>
      <v-card height="300" color="grey lighten-4" elevation="4" @click.stop="$store.commit('addSticky')">
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
        timeout: null,
      };
    },
    computed: {
      stickies: {
        get() {
          return this.$store.state.stickies;
        }
      }
    },
    mounted: function() {
      this.$store.commit('loadStickies');
    }
  }
</script>