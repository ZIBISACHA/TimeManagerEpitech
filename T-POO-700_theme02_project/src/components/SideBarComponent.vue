<template>
  <div class="ma-12 pa-12">
      <v-card>
          <v-navigation-drawer
          permanent
          expand-on-hover
          app

          >
            <v-list>
              <v-list-item class="px-2">
                <v-list-item-avatar class="myAvatar" >
                  <img src="https://randomuser.me/api/portraits/men/21.jpg">
                </v-list-item-avatar>
              </v-list-item>
              <v-list-item link v-on:click="redirectUserInfo">
                <v-list-item-content>
                  <v-list-item-title class="text-h6">
                    {{ this.username }}
                  </v-list-item-title>
                  <v-list-item-subtitle>
                    {{ this.email }}
                  </v-list-item-subtitle>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          <v-divider></v-divider>
          <v-list-item link v-on:click="redirectHome">
            <v-list-item-icon>
              <img class="myIcon" src="../../public/home-icon.png">
            </v-list-item-icon>
            <v-list-item-title>
                Home
            </v-list-item-title>
          </v-list-item>
          <v-list-item link v-on:click="redirectChartManagement">
            <v-list-item-icon>
              <img class="myIcon" src="../../public/chart-icon.png">
            </v-list-item-icon>
            <v-list-item-title>
                Chart Management
            </v-list-item-title>
          </v-list-item>
          <v-list-item link v-on:click="redirectCalendar">
            <v-list-item-icon>
              <img class="myIcon" src="../../public/calendar-icon.png">
            </v-list-item-icon>
            <v-list-item-title>
                Calendar
            </v-list-item-title>
          </v-list-item>
          <v-list-item link v-on:click="redirectUserInfo">
            <v-list-item-icon>
              <img class="myIcon" src="../../public/user-icon.png">
            </v-list-item-icon>
            <v-list-item-title>
                User Info
            </v-list-item-title>
          </v-list-item>
          </v-navigation-drawer>
      </v-card>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  created() {
    this.userID = localStorage.getItem('userID');
    this.getUserInfo();
  },
  data() {
    return {
      errors: [],
      username: null,
      email: null,
      Role: null,
      Teams: null,
      userID: null
    }
  },
  methods : {
    redirectHome(e) {
      e.preventDefault()
      this.$router.push("/")
    },
    redirectUserInfo(e) {
      e.preventDefault()
      this.$router.push("/user/" + this.userId)
    },
    redirectChartManagement(e) {
      e.preventDefault()
      this.$router.push("/chart")
    },
    redirectCalendar(e) {
      e.preventDefault()
      this.$router.push("/user/" + this.userId)
    },
    getUserInfo() {
      axios.get('http://localhost:4000/api/users/' + 1, {'mode': 'cors'})
        .then(response => {
            this.userID = response.data.user['id']
            this.username = response.data.user['username']
            this.email = response.data.user['email']
            })
        .catch(err => {console.error(err)})
    }
  }
}
</script>

<style>
  .myIcon {
    width: 25px;
    height: 25px;
  }
  .myAvatar {
    width: 50%;
  }
</style>