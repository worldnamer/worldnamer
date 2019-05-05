<template>
  <v-app>
  <div id='app-body'>
    <TopNav></TopNav>
    <router-view></router-view>
  </div>
  </v-app>
</template>

<script>
  import TopNav from '../components/TopNav'
  export default {
    name: 'app',
    components: {
      'TopNav': TopNav
    }
  }
</script>