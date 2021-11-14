<template>
  <div id="app">
    <div id="nav">
      <home-view />
    </div>
  </div>
</template>

<script>
import HomeView from '../src/views/Home.vue'

export default {
  name: 'Home',
  components: {
    HomeView
  }
}
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
