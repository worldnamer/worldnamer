<template>
  <v-toolbar dark color="primary" v-if="$store.getters.loggedIn">
    <v-toolbar-title class="white--text" @click.stop="dashboard()">worldnamer</v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn icon @click.stop="projects()">
      <v-icon>folder_open</v-icon>
    </v-btn>

    <v-btn icon @click.stop="media()">
      <v-icon>theaters</v-icon>
    </v-btn>

    <v-btn icon @click.stop="plan()">
      <v-icon>show_chart</v-icon>
    </v-btn>

    <v-btn icon @click.stop="logOut()">
      <v-icon>power_settings_new</v-icon>
    </v-btn>
  </v-toolbar>
</template>

<script>
  export default {
    methods: {
      dashboard: function() {
        this.$router.push('/dashboard');
      },
      projects: function() {
        this.$router.push('/projects');
      },
      media: function() {
        this.$router.push('/media');
      },
      plan: function() {
        this.$router.push('/plan');
      },
      logOut: function () {
        this.$store.commit('logOut');
        this.$router.push('/');
      }
    }
  }
</script>