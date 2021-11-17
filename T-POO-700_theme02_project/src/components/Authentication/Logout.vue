<template>
  <v-btn v-on:click="logout()" id="logout">Logout</v-btn>
</template>

<script>
import axios from "axios";
export default {
  name: "Logout",
  methods: {
    logout: function () {
      console.log("jwt before logout", localStorage.getItem("user"));
      localStorage.removeItem("user");
      localStorage.removeItem("userID");
      console.log("jwt after logout", localStorage.getItem("user"));
      axios
        .post("http://localhost:4000/api/users/sign_out", { mode: "cors" })
        .then((response) => {
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
