<template>
  <v-app>
    <div class="mainContainer">
      <side-bar-component />
      <h3>My charts</h3>
      <current-user-charts
        :startDatetime="'2021-01-01 00:00:00'"
        :endDatetime="'2021-12-31 00:00:00'"
        :type="'currentUser'"
      />
      <h3>Team charts</h3>
      <div class="chart">
        <team-charts
          v-if="userTeamID"
          :teamID="userTeamID"
          :startDatetime="'2021-01-01 00:00:00'"
          :endDatetime="'2021-12-31 00:00:00'"
        />
      </div>
      <h3>Employee charts</h3>
      <div class="chart">
        <selected-employee-charts
          :startDatetime="'2021-01-01 00:00:00'"
          :endDatetime="'2021-12-31 00:00:00'"
          :type="'otherEmployee'"
        />
      </div>
    </div>
  </v-app>
</template>

<script>
import TeamCharts from "./TeamCharts.vue";
import CurrentUserCharts from "./CurrentUserCharts.vue";
import SelectedEmployeeCharts from "./SelectedEmployeeCharts.vue";
import SideBarComponent from "../SideBarComponent.vue";
import { getUserDetails } from "../Authentication/Login.vue";
import axios from "axios";

export default {
  name: "ManagerCharts",
  components: {
    TeamCharts,
    CurrentUserCharts,
    SideBarComponent,
    SelectedEmployeeCharts,
  },
  data: () => ({
    currentUserID: null,
    items: [],
    userTeamID: null,
  }),
  methods: {
    getSelectedEmployee() {
      this.$forceUpdate;
    },
    async getUserTeam(userID) {
      axios
        .get("http://localhost:4000/api/teams/" + userID, {
          mode: "cors",
          headers: {
            Authorization: "Bearer " + localStorage.getItem("user"),
          },
        })
        .then((response) => {
          if (response.data.team.id) {
            this.userTeamID = response.data.team.id;
          }
          for (let y = 0; y < response?.data?.members?.length; y++) {
            this.items.push({
              username: response?.data?.members?.[y].username,
              id: response?.data?.members?.[y].id,
            });
          }
        })
        .catch((err) => {
          console.error(err);
        });
    },
  },
  mounted() {
    const id = getUserDetails();
    if (id) {
      console.log(parseInt(id));
      this.currentUserID = parseInt(id);
      this.getUserTeam(id);
      console.log("user team", this.userTeamID);
    }
    this.$forceUpdate();
  },
};
</script>
<style>
.chart {
  flex-direction: row;
}
.mainContainer {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  margin-top: 50px;
}
</style>
