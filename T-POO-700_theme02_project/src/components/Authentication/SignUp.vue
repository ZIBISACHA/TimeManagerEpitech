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
      <v-app id="appa">
        <v-select
            :items="items"
            label="Role"
            item-text="name"
            item-value="id"
            v-model="input.role_id"
          ></v-select>
      </v-app>
      <v-card-actions>
        <v-btn
          :disabled="!isValid"
          v-on:click="
            register({
              email: input.email,
              username: input.username,
              password: input.password,
              password_confirmation: input.password_confirmation,
              role_id: input.role_id,
            })
          "
          >Register</v-btn
        >
      </v-card-actions>
    </v-card>
    <router-link to="/login"
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
        role_id: null,
      },
      items: [{id: 1, name: "Employee"}, {id: 3, name: "Manager"}],
      isValid: true,
    };
  },
  methods: {
    register: function (data) {
      axios
        .post(
          "http://localhost:4000/auth/sign_up",
          { user: {...data} },
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
#appa {
  width: 4em;
  height: 4em;
}
</style>
