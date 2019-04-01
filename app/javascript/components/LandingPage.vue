<template>
  <div class='splash' v-on:mouseover='mouseOver' v-on:mouseleave='mouseLeave'>
    <div class='logo'><span class='first-letter'>w</span><span :class='textClass'>orldnamer</span></div>
    <div :class='linksClass'>
      <a href="https://stackoverflow.com/cv/worldnamer">Résumé</a>
      <a href="http://twitter.com/worldnamer">@worldnamer</a>
      <router-link to="/login">Log In</router-link>
    </div>
  </div>

</template>

<script>
  export default {
    data: function () {
      return {
        hover: false,
        textClass: 'short-logo',
        linksClass: 'links'
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
      }
    }
  }
</script>
