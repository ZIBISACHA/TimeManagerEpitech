<template>
  <div class="chart">
    <line-chart
      :chartdata="dailyChartdata"
      :options="options"
      :key="dailyCount"
    />
    <bar-chart
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
</template>

<script>
import LineChart from "../LineChart.vue";
import BarChart from "../BarChart.vue";
import DoughnutChart from "../DoughnutChart.vue";
import _ from "lodash";
import { getEveryDayWorkingtimes, getAverageTime } from "./ChartsFunctions.js";
import axios from "axios";
import { getUserDetails } from "../Authentication/Login.vue";

export default {
  name: "CurrentUserCharts",
  components: { LineChart, BarChart, DoughnutChart },
  props: {
    employeeID: Number,
    startDatetime: String,
    endDatetime: String,
    type: String,
  },
  data: () => ({
    dailyChartdata: null,
    weeklyCount: 0,
    dailyCount: 10,
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
  created() {
    const userID = getUserDetails();
    this.getAverageWorkingtime(userID);
  },
  methods: {
    getAverageWorkingtime(userID) {
      try {
        axios
          .get(
            `http://localhost:4000/api/workingtimes/${userID}?start=${this.startDatetime}&end=${this.endDatetime}`,
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
                  label: "My daily workingtimes average (hour)",
                  data: dailyValues,
                  backgroundColor,
                },
              ],
            };

            this.weeklyChartdata = {
              labels: weeklyLabels,
              datasets: [
                {
                  label: "Mys weekly workingtimes average by month (hour)",
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
  mounted() {
    this.dailyCount += 1;
    this.weeklyCount += 1;
  },
};
</script>
