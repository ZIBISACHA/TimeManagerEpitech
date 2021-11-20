<template>
  <div>
    <v-container fluid>
      <v-row align="center">
        <v-col class="d-flex" cols="12" sm="6">
          <v-select
            v-model="selected"
            :items="items"
            item-text="username"
            item-value="id"
            label="Select an employee"
            solo
          ></v-select>
        </v-col>
      </v-row>
    </v-container>
    <div class="chart">
      <line-chart
        v-if="selected"
        :chartdata="dailyChartdata"
        :options="options"
        :key="dailyCount"
      />
      <bar-chart
        v-if="selected"
        :chartdata="weeklyChartdata"
        :options="options"
        :key="weeklyCount"
      />
      <doughnut-chart
        :chartdata="weeklyChartdata"
        :options="optionsCircle"
        :key="weeklyCount"
      />
    </div>
  </div>
</template>

<script>
import LineChart from "../LineChart.vue";
import BarChart from "../BarChart.vue";
import DoughnutChart from "../DoughnutChart.vue";
import _ from "lodash";
import { getEveryDayWorkingtimes, getAverageTime } from "./ChartsFunctions.js";
import { getUserDetails } from "../Authentication/Login.vue";
import axios from "axios";

export default {
  name: "SelectedEmployeeCharts",
  components: { LineChart, BarChart, DoughnutChart },
  props: {
    startDatetime: String,
    endDatetime: String,
  },
  data: () => ({
    employeeDailyChartDataFromJs: null,
    employeeWeeklyChartDataFromJs: null,
    items: [],
    selected: null,
    weeklyCount: 0,
    dailyCount: 10,
    dailyChartdata: null,
    weeklyChartdata: null,
    optionsCircle: {
      responsive: true,
      maintainAspectRatio: false,
      lineTension: 1,
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      lineTension: 1,
      scales: {
        yAxes: [
          {
            ticks: {
              beginAtZero: true,
              padding: 20,
            },
          },
        ],
      },
    },
  }),
  mounted() {
    const userRole = localStorage.getItem("userRole");
    const userID = getUserDetails();
    this.getUserTeam(userID, userRole);
  },
  methods: {
    async getUserTeam(userID, userRole) {
      const request =
        userRole == 2
          ? "http://localhost:4000/api/users"
          : "http://localhost:4000/api/teams/" + userID;

      axios
        .get(request, {
          mode: "cors",
          headers: {
            Authorization: "Bearer " + localStorage.getItem("user"),
          },
        })
        .then((response) => {
          if (userRole == 2) {
            console.log("main response", response.data.data.length);
            for (let y = 0; y < response?.data?.data?.length; y++) {
              this.items.push({
                username: response?.data?.data?.[y]?.username,
                id: response?.data?.data?.[y]?.id,
              });
            }
          } else {
            for (let y = 0; y < response?.data?.members?.length; y++) {
              this.items.push({
                username: response?.data?.members?.[y].username,
                id: response?.data?.members?.[y].id,
              });
            }
          }
          this.$forceUpdate();
        })
        .catch((err) => {
          console.error(err);
        });
    },

    getAverageWorkingtime() {
      try {
        axios
          .get(
            `http://localhost:4000/api/workingtimes/${this.selected}?start=${this.startDatetime}&end=${this.endDatetime}`,
            {
              mode: "cors",
              headers: {
                Authorization: "Bearer " + localStorage.getItem("user"),
              },
            }
          )
          .then((response) => {
            const workingtimesListByDay = getEveryDayWorkingtimes(
              response?.data?.data
            );
            const averageByDay = getAverageTime(
              workingtimesListByDay,
              response?.data?.data,
              "daily"
            );
            const averageByWeek = getAverageTime(
              workingtimesListByDay,
              response?.data?.data,
              "weekly"
            );

            const backgroundColor = [
              "rgba(255, 99, 132, 0.4)",
              "rgba(54, 162, 235, 0.4)",
              "rgba(255, 206, 86, 0.4)",
              "rgba(75, 192, 192, 0.4)",
              "rgba(153, 102, 255, 0.4)",
              "rgba(255, 159, 64, 0.4)",
            ];

            const dailyValues = _.map(averageByDay, (w) => w?.value);
            const dailyLabels = _.map(averageByDay, (w) => w?.label);
            const weeklyValues = _.map(averageByWeek, (w) => w?.value);
            const weeklyLabels = _.map(averageByWeek, (w) => w?.label);

            this.dailyChartdata = {
              labels: dailyLabels,
              datasets: [
                {
                  label: "Employee's daily workingtimes average (hour)",
                  data: dailyValues,
                  backgroundColor,
                },
              ],
            };

            this.weeklyChartdata = {
              labels: weeklyLabels,
              datasets: [
                {
                  label:
                    "Employee's weekly workingtimes average by month (hour)",
                  data: weeklyValues,
                  backgroundColor,
                },
              ],
            };

            this.weeklyCount += 1;
            this.dailyCount += 1;
          })
          .catch((err) => {
            console.log(err);
          });
      } catch (e) {
        console.error(e);
      }
    },
  },
  watch: {
    selected: function () {
      this.getAverageWorkingtime();
      this.$forceUpdate;
    },
  },
};
</script>
