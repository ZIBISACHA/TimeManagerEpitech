<template>
  <div id="app">
    <div id="nav">
      <notifications position="top right"/>
      <router-view>
        <div v-if="!isAuthenticated">
          <Login />
          <router-link to="/register"
            >You don't have any account yet? Register here!</router-link
          >
        </div>
        <home-view v-if="isAuthenticated" />
      </router-view>
    </div>
  </div>
</template>

<script>
import HomeView from "../src/views/Home.vue";
import Login from "../src/components/Authentication/Login.vue";

export default {
  name: "MainHome",
  components: {
    HomeView,
    Login,
  },
  data: () => ({
    isAuthenticated: false,
  }),
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
