<template>
  <div class='splash' v-on:mouseover='mouseOver' v-on:mouseleave='mouseLeave'>
    <div class='logo'><span class='first-letter'>w</span><span :class='textClass()'>orldnamer</span></div>
    <div :class='linksClass()'>
      <a href="https://stackoverflow.com/cv/worldnamer">Résumé</a>
      <a href="http://twitter.com/worldnamer">@worldnamer</a>
  
      <v-dialog v-model="dialog" max-width="500px">
        <template v-slot:activator="{ on }">
          <a href="#" v-on="on">Log In</a>
        </template>
        <v-card>
          <v-card-actions>
            <v-text-field label="password" :hide-details="true" outline type="password" value="" counter v-model="password"></v-text-field>
            <v-btn color="primary" flat @click.stop="submit()" style="margin-left: 8px">Log In</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </div>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        hover: false,
        dialog: false,
        password: ''
      }
    },
    methods: {
      mouseOver: function() {
        this.hover = true;
      },
      mouseLeave: function() {
        this.hover = false;
      },
      textClass: function() {
        if (this.hover || this.dialog) {
          return 'short-logo-hover';
        } else {
          return 'short-logo';
        }
      },
      linksClass: function() {
        if (this.hover || this.dialog) {
          return 'links-hover';
        } else {
          return 'links';
        }
      },
      submit: function() {
        this.dialog=false; 
        this.hover=true;

        // This should be replaced with a login.
        this.$store.state.sessionKey = 'dashboard';
        this.$router.push('/dashboard');
      }
    }
  }
</script>
