<template>
  <div>
    <v-card id="register">
      <v-card-title>Register</v-card-title>
      <v-card-text>
        <v-form v-model="isValid">
          <v-text-field
            label="Username"
            v-model="input.username"
            type="username"
            required
            :rules="[(v) => !!v || 'Username is required']"
          ></v-text-field>
          <v-text-field
            label="Email"
            type="email"
            v-model="input.email"
            error-count="2"
            required
            :rules="[
              (v) => !!v || 'Email is required',
              (v) =>
                /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/.test(v) ||
                'E-mail format must be valid (example@company.com)',
            ]"
          ></v-text-field>
          <v-text-field
            label="Password"
            v-model="input.password"
            type="password"
            required
            error-count="2"
            :rules="[
              (v) => !!v || 'Password is required',
              (v) =>
                (v && v.length >= 6) ||
                'Password must have at least 6 characters',
            ]"
          ></v-text-field>
          <v-text-field
            label="Password confirmation"
            v-model="input.password_confirmation"
            type="password"
            required
            error-count="2"
            :rules="[
              (v) => !!v || 'Password confirmation is required',
              (v) =>
                (v && v.length >= 6) ||
                'Password must have at least 6 characters',
            ]"
          ></v-text-field>
        </v-form>
      </v-card-text>
      <v-card-actions>
        <v-btn
          :disabled="!isValid"
          v-on:click="
            register({
              email: input.email,
              username: input.username,
              password: input.password,
              password_confirmation: input.password_confirmation,
            })
          "
          >Register</v-btn
        >
      </v-card-actions>
    </v-card>
    <router-link to="/register"
      >You already have an account? Sign in here!</router-link
    >
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "SignUp",
  data() {
    return {
      input: {
        email: null,
        password: null,
        password_confirmation: null,
        username: null,
      },
      isValid: true,
    };
  },
  methods: {
    register: function (data) {
      axios
        .post(
          "http://localhost:4000/api/users/sign_up",
          { user: { ...data } },
          { mode: "cors" }
        )
        .then((response) => {
          console.log("response", response);
          this.$router.push("/login");
        })
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#register {
  width: 500px;
  border: 1px solid #cccccc;
  background-color: #ffffff;
  margin: auto;
  margin-top: 100px;
  margin-bottom: 20px;
  padding: 20px;
}
</style>
