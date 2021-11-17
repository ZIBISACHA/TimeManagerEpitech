<template>
  <div>
    <v-card id="login">
      <v-card-title>Login</v-card-title>
      <v-card-text>
        <v-form v-model="isValid">
          <v-text-field
            label="Email"
            type="email"
            v-model="input.email"
            required
            :rules="[(v) => !!v || 'Email is required']"
          ></v-text-field>
          <v-text-field
            label="Password"
            v-model="input.password"
            type="password"
            required
            :rules="[(v) => !!v || 'Password is required']"
          ></v-text-field>
        </v-form>
      </v-card-text>
      <v-card-actions>
        <v-btn
          v-on:click="login({ email: input.email, password: input.password })"
          :disabled="!isValid"
          >Login</v-btn
        >
      </v-card-actions>
    </v-card>
    <router-link to="/register"
      >You don't have any account yet? Register here!</router-link
    >
  </div>
</template>

<script>
import axios from "axios";
import VueJwtDecode from "vue-jwt-decode";
export default {
  name: "Login",
  data() {
    return {
      input: {
        email: null,
        password: null,
        role: null,
      },
      isValid: true,
    };
  },
  mounted() {
    // console.log("id", this.getUserDetails());
  },
  methods: {
    login: function (data) {
      axios
        .post("http://localhost:4000/auth/sign_in", data, { mode: "cors" })
        .then((response) => {
          if (response.data.jwt) {
            const jwtToString = response.data.jwt;
            localStorage.setItem("user", jwtToString);
            console.log("user jwt", localStorage.user);
            let decoded = VueJwtDecode.decode(localStorage.user);
            localStorage.setItem("userID", decoded.sub);
            this.$router.push("/");
          }
          return response.data;
        })
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
    getUserDetails: function () {
      // get token from localstorage
      let token = localStorage.getItem("user");
      try {
        //decode token here and attach to the user object
        let decoded = VueJwtDecode.decode(token);
        this.id = decoded.sub;
        return decoded.sub;
      } catch (error) {
        // return error in production env
        console.log(error, "error from decoding token");
      }
    },
  },
};
</script>

<style scoped>
#login {
  width: 500px;
  border: 1px solid #cccccc;
  background-color: #ffffff;
  margin: auto;
  margin-top: 100px;
  margin-bottom: 20px;
  padding: 20px;
}
</style>
