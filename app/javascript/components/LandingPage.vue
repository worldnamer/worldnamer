<template>
  <div class='splash' v-on:mouseover='mouseOver' v-on:mouseleave='mouseLeave'>
    <div class='logo'><span class='first-letter'>w</span><span :class='textClass'>orldnamer</span></div>
    <div :class='linksClass'>
      <a href="https://stackoverflow.com/cv/worldnamer">Résumé</a>
      <a href="http://twitter.com/worldnamer">@worldnamer</a>
      <a href="#" @click.prevent="logIn">Log In</a>
    </div>

    <v-dialog v-model="show" max-width="500px">
      <v-card>
        <v-card-actions>
          <v-text-field label="password" outline></v-text-field>
          <v-btn color="primary" flat @click.stop="dialog=false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
  export default {
    computed: {
      show: {
        get () {
          return this.dialog;
        },
        set (value) {
          if (!value) {
            this.$emit('close')
          }
        }
      }
    },    
    data: function () {
      return {
        hover: false,
        textClass: 'short-logo',
        linksClass: 'links',
        password: '',
        dialog: false
      }
    },
    methods: {
      mouseOver: function() {
        this.hover = true;
        this.textClass = 'short-logo-hover';
        this.linksClass = 'links-hover';
      },
      mouseLeave: function() {
        this.hover = false;
        this.textClass = 'short-logo';
        this.linksClass = 'links';
      },
      logIn: function() {
        this.dialog=true;
      }
    }
  }
</script>
