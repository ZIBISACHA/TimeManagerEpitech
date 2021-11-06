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
                    Jon Doe
                  </v-list-item-title>
                  <v-list-item-subtitle>
                    Jon@Doe.fr
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
export default {
  setup() {
    this.userID = localStorage('UserID');
  },
  data() {
    return {
      errors: [],
      username: null,
      email: null,
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
      this.$router.push("/user/"/*  + userId */)
    },
    redirectChartManagement(e) {
      e.preventDefault()
      this.$router.push("/chart")
    },
    redirectCalendar(e) {
      e.preventDefault()
      this.$router.push("/user/"/*  + userId */)
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