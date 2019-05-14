<template>
  <v-layout row wrap pa-2>
    <v-flex xs3 pa-2 v-for="project in projects" v-bind:key="project.id">
      <v-card>
        <v-img
          class="white--text"
          height="200px"
          :src="project.img"
        >
          <v-container fill-height fluid>
            <v-layout fill-height>
              <v-flex xs12 align-end flexbox>
                <span class="headline" style="background-color: rgba(0,0,0,0.5); padding: 8px 8px 8px 8px;">{{ project.name }}</span>
              </v-flex>
            </v-layout>
          </v-container>
        </v-img>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default {
    data () {
      return {
        projects: [
          { img: 'https://www.clydeco.com/images/made/uploads/Images/New_service_images/Projects_Construct/Projects-Construction_1600x1066_1600_1066_80_s_c1_c_c.jpg', name: 'worldnamer.com improvements' },
          { img: 'https://img.buzzfeed.com/buzzfeed-static/static/2014-07/15/18/enhanced/webdr05/original-16916-1405464578-38.jpg?output-quality=auto&output-format=auto', name: 'Learn to Cook' },
          { img: 'https://vuejs.org/images/logo.png', name: 'VUE' }
        ]
      }
    }
  }
</script>