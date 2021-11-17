<template>
  <v-app>
    <div class="mainContainer">
      <side-bar-component />
      <h3>My charts</h3>
      <employee-charts
        :employeeID="2"
        :startDatetime="'2021-01-01 00:00:00'"
        :endDatetime="'2021-12-31 00:00:00'"
        :type="'currentUser'"
        :key="currentUserID"
      />
      <h3>Team charts</h3>
      <div class="chart">
        <team-charts
          :teamID="1"
          :startDatetime="'2021-01-01 00:00:00'"
          :endDatetime="'2021-12-31 00:00:00'"
        />
      </div>
      <h3>Employee charts</h3>

      <v-container fluid>
        <v-row align="center">
          <v-col class="d-flex" cols="12" sm="6">
            <v-select
              :items="items"
              item-text="username"
              item-value="id"
              label="Select an employee"
              solo
            ></v-select>
          </v-col>
        </v-row>
      </v-container>

      <employee-charts
        :employeeID="selected"
        :startDatetime="'2021-01-01 00:00:00'"
        :endDatetime="'2021-12-31 00:00:00'"
        :type="'otherEmployee'"
      />
    </div>
  </v-app>
</template>

<script>
import TeamCharts from "./TeamCharts.vue";
import EmployeeCharts from "./EmployeeCharts.vue";
import SideBarComponent from "../SideBarComponent.vue";
import { getUserDetails } from "../Authentication/Login.vue";
import axios from "axios";

export default {
  name: "ManagerCharts",
  components: {
    TeamCharts,
    EmployeeCharts,
    SideBarComponent,
  },
  data: () => ({
    currentUserID: null,
    items: [
      { username: "martin", id: 1 },
      { username: "pierre", id: 2 },
      { username: "paul", id: 3 },
    ],
    selected: null,
    userTeam: null,
  }),
  methods: {
    async getUserTeam(userID) {
      axios
        .get("http://localhost:4000/api/teams/" + userID, { mode: "cors" })
        .then((response) => {
          this.userTeam = response.data.data;
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
    }
    this.getUserTeam(id);
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
