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
export default {
  name: "TeamCharts",
  components: { LineChart, BarChart, DoughnutChart },
  props: {
    teamID: Number,
    startDatetime: String,
    endDatetime: String,
  },
  data: () => ({
    dailyChartdata: null,
    weeklyChartdata: null,
    weeklyCount: 0,
    dailyCount: 10,
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
    this.getAverageWorkingtime();
  },
  methods: {
    getAverageWorkingtime() {
      try {
        axios
          .get(
            `http://localhost:4000/api/workingtimes/team/${this.teamID}?start=${this.startDatetime}&end=${this.endDatetime}`,
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
                  label:
                    "Team's daily workingtimes average for an employee (hour)",
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
                    "Team's weekly workingtimes average by month for the whole team",
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
};
</script>
<style>
.chart {
  display: flex;
  flex-wrap: wrap;
}
</style>
