<template>
  <div class="chart">
    <line-chart :chartdata="dailyChartdata" :options="options" />
    <bar-chart :chartdata="weeklyChartdata" :options="options" />
    <doughnut-chart :chartdata="weeklyChartdata" :options="optionsCircle" />
  </div>
</template>

<script>
import LineChart from "../LineChart.vue";
import BarChart from "../BarChart.vue";
import DoughnutChart from "../DoughnutChart.vue";
import _ from "lodash";
import { getTeamAverageWorkingtime } from "./ChartsFunctions.js";

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
    console.log("teamID" + this.teamID);
    const request = ` http://localhost:4000/api/workingtimes/team/${this.teamID}?start=${this.startDatetime}&end=${this.endDatetime}`;
    const getTeamDailyData = getTeamAverageWorkingtime(true, request, "team");
    const getTeamWeeklyData = getTeamAverageWorkingtime(false, request, "team");
    let values;
    let labels;
    let weeklyValues;
    let weeklyLabels;
    const backgroundColor = [
      "rgba(255, 99, 132, 0.4)",
      "rgba(54, 162, 235, 0.4)",
      "rgba(255, 206, 86, 0.4)",
      "rgba(75, 192, 192, 0.4)",
      "rgba(153, 102, 255, 0.4)",
      "rgba(255, 159, 64, 0.4)",
    ];
    if (getTeamDailyData) {
      values = _.map(getTeamDailyData?.[0], (w) => w?.value);
      labels = _.map(getTeamDailyData?.[0], (w) => w?.label);
      if (values && labels) {
        this.dailyChartdata = {
          labels,
          datasets: [
            {
              label: "Team's daily workingtimes average for an employee (hour)",
              data: values,
              backgroundColor,
            },
          ],
        };
      }
    }
    if (getTeamWeeklyData) {
      weeklyValues = _.map(getTeamWeeklyData?.[0], (w) => w?.value);
      weeklyLabels = _.map(getTeamWeeklyData?.[0], (w) => w?.label);
      if (weeklyValues && weeklyLabels) {
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
      }
    }
  },
};
</script>
<style>
.chart {
  display: flex;
  flex-wrap: wrap;
}
</style>
