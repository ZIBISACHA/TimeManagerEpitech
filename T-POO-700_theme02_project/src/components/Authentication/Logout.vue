<template>
  <v-btn v-on:click="logout()" id="logout">Logout</v-btn>
</template>

<script>
import axios from "axios";
export default {
  name: "Logout",
  methods: {
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

          localStorage.removeItem("user");
          localStorage.removeItem("userID");
          localStorage.removeItem("userRole");

          console.log("response", response);
        })
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
  },
};
</script>

<style scoped>
#logout {
  margin: 100px;
}
</style>
