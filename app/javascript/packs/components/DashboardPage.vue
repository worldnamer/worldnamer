<template>
  <div>
    Logged In <v-btn color="primary" flat @click.stop="logOut()" style="margin-left: 8px">Log Out</v-btn>
  </div>
</template>

<script>
  export default {
    methods: {
      logOut: function () {
        this.$store.commit('logOut');
        this.$router.push('/');
      }
    }
  }
</script>