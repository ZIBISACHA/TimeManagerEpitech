<template>
  <div>
    <SignUp />
    <Login />
    <Logout />
  </div>
</template>

<script>
// @ is an alias to /src
import Logout from "@/components/Authentication/Logout.vue";
import Login from "@/components/Authentication/Login.vue";
import SignUp from "@/components/Authentication/SignUp.vue";
export default {
  name: "AuthenticationManager",
  components: {
    Logout,
    Login,
    SignUp,
  },
};
</script>

<style></style>
