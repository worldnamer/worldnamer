<template>
  <div id='login-form'>
    <router-link to="/"><p>{{ message }}</p></router-link>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "home"
      }
    }
  }
</script>
