<template>
  <div class="ma-12 pa-12">
    <v-card v-if="this.$vuetify.breakpoint.width > 960">
      <v-navigation-drawer permanent expand-on-hover app>
        <v-list>
          <v-list-item class="px-2">
            <v-list-item-avatar class="myAvatar">
              <img src="https://randomuser.me/api/portraits/men/21.jpg" />
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
            <img class="myIcon" src="../../public/home-icon.png" />
          </v-list-item-icon>
          <v-list-item-title> Home </v-list-item-title>
        </v-list-item>
        <v-list-item link v-on:click="redirectChartManagement">
          <v-list-item-icon>
            <img class="myIcon" src="../../public/chart-icon.png" />
          </v-list-item-icon>
          <v-list-item-title> Chart Management </v-list-item-title>
        </v-list-item>
        <!-- <v-list-item link v-on:click="redirectCalendar">
          <v-list-item-icon>
            <img class="myIcon" src="../../public/calendar-icon.png" />
          </v-list-item-icon>
          <v-list-item-title> Calendar </v-list-item-title>
        </v-list-item> -->
        <v-list-item link v-on:click="redirectUserInfo">
          <v-list-item-icon>
            <img class="myIcon" src="../../public/user-icon.png" />
          </v-list-item-icon>
          <v-list-item-title> User Info </v-list-item-title>
        </v-list-item>
        <v-list-item link v-on:click="redirectTeaminfo">
          <v-list-item-icon>
            <v-icon>mdi-account-group-outline</v-icon>
          </v-list-item-icon>
          <v-list-item-title> Teams Info </v-list-item-title>
        </v-list-item>
        <v-list-item link v-on:click="redirectAdmin">
          <v-list-item-icon>
            <v-icon>mdi-account-group-outline</v-icon>
          </v-list-item-icon>
          <v-list-item-title> Admin </v-list-item-title>
        </v-list-item>
        <v-list-item link v-on:click="redirectLogin">
          <v-list-item-icon>
            <v-icon color='#000000'>mdi-logout</v-icon>
          </v-list-item-icon>
          <v-list-item-title> Logout </v-list-item-title>
        </v-list-item>
      </v-navigation-drawer>
    </v-card>
    <v-card v-else absolute>
      <v-bottom-navigation fixed :value="value" color="primary">
        <v-btn link v-on:click="redirectHome">
          <span>Home</span>

          <img class="myIcon" src="../../public/home-icon.png" />
        </v-btn>

        <v-btn link v-on:click="redirectChartManagement">
          <span>Chart Management</span>

          <img class="myIcon" src="../../public/chart-icon.png" />
        </v-btn>

        <!-- <v-btn link v-on:click="redirect">
          <span>Calendar</span>

          <img class="myIcon" src="../../public/calendar-icon.png" />
        </v-btn> -->
        <v-btn link v-on:click="redirectUserInfo">
          <span>User Info</span>

          <img class="myIcon" src="../../public/user-icon.png" />
        </v-btn>
        <v-btn link v-on:click="redirectTeaminfo">
          <span>Team Info</span>
          <v-icon>mdi-account-group-outline</v-icon>
        </v-btn>
        <v-btn link v-on:click="redirectLogin">
          <span>Logout</span>
          <v-icon>mdi-logout</v-icon>
        </v-btn>
      </v-bottom-navigation>
    </v-card>
  </div>
</template>

<script>
import axios from "axios";

export default {
  created() {
    this.userID = localStorage.getItem("userID");
    this.getUserInfo();
    
  },
  data() {
    return {
      errors: [],
      username: null,
      email: null,
      Role: null,
      Teams: null,
      userID: null,
    };
  },
  methods: {
    redirectHome(e) {
      e.preventDefault();
      this.$router.push("/");
    },
    redirectUserInfo(e) {
      e.preventDefault();
      this.$router.push({path: '/userinfo/' + localStorage.userID});
    },
    redirectChartManagement(e) {
      e.preventDefault();
      this.$router.push("/chart");
    },
    // redirectCalendar(e) {
    //   e.preventDefault();
    //   this.$router.push("/user/" + this.userId);
    // },
    redirectAdmin(e) {
      e.preventDefault();
      if (this.Role == 2) {
        this.$router.push("/admin");
      }
    },
    redirectLogin(e) {
      e.preventDefault();
      this.logout();
      this.$router.push("/login");
    },
    redirectTeaminfo(e) {
      e.preventDefault();
      this.$router.push("/teams");
    },
    logout: function () {
      const config = {
        mode: "cors",
        headers: {
        "Authorization": "Bearer " + localStorage.user
        }
      }
      axios
        .post("http://localhost:4000/api/users/sign_out", config)
        .then((response) => {
          console.log("response", response);
          console.log("jwt before logout", localStorage.getItem("user"));
          localStorage.removeItem("user");
          localStorage.removeItem("userID");
          console.log("jwt after logout", localStorage.getItem("user"));
        })
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
    getUserInfo() {
      const config = {
        mode: "cors",
        headers: {
        "Authorization": "Bearer " + localStorage.user
        }
      }
      axios
        .get(
          "http://localhost:4000/api/users/" + this.userID, 
          config
        )
        .then((response) => {
          this.userID = response.data["id"];
          this.username = response.data["username"];
          this.email = response.data["email"];
          this.Role = response.data["role"];
        })
        .catch((err) => {
          console.error(err);
        });
    },
  },
};
</script>

<style>
.myIcon {
  width: 25px;
  height: 25px;
}
.myAvatar {
  width: 50%;
}

@media (max-width: 960px) {
}
</style>
