<template>
  <div id="app">
    <div id="nav">
      <router-link to="/home">Home</router-link> |
      <router-link :to="{ name: 'userinfo', params: { id: '1'} }">User</router-link> |
      <router-link :to="{ name: 'clockManager', params: { username: '1'} }">Clock</router-link> |
      <router-link :to="{ name: 'workingTime', params: { userID: '1', type: 'creation' }, query: {type: 'creation'}}">Ajouter un temps de travail</router-link> |
      <router-link :to="{ name: 'workingTimeModifier', params: { userID: '1', workingtimeid: '19' }, query: {type: 'del'}}">Supprimer un temps de travail</router-link> |
      <router-link :to="{ name: 'workingTimeModifier', params: { userID: '1', workingtimeid: '19'}, query: {type: 'update'}}">Modifier un temps de travail</router-link> |
      <router-link :to="{ name: 'workingTimes', params: { id: '1' }}">Voir les temps de travail</router-link> |
      <router-link :to="{ name: 'chartManager', params: { id: '1' }}">Chart Manager</router-link> 
    </div>
    <router-view/>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
