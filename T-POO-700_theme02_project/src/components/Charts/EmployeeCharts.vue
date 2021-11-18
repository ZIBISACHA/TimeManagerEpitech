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
  name: "EmployeeCharts",
  components: { LineChart, BarChart, DoughnutChart },
  props: {
    employeeID: Number,
    startDatetime: String,
    endDatetime: String,
    type: String,
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
  mounted() {
    
    console.log("EmployeeId",this.employeeID);
    console.log('tes')
    const request = `http://localhost:4000/api/workingtimes/${this.employeeID}?start=${this.startDatetime}&end=${this.endDatetime}`;
    const getEmployeeDailyData = getTeamAverageWorkingtime(true, request, this.type);
    const getEmployeeWeeklyData = getTeamAverageWorkingtime(false, request, this.type);

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

    if (getEmployeeDailyData) {
      values = _.map(getEmployeeDailyData?.[0], (w) => w?.value);
      labels = _.map(getEmployeeDailyData?.[0], (w) => w?.label);
      if (values && labels) {
        this.dailyChartdata = {
          labels,
          datasets: [
            {
              label: "Employee's daily workingtimes average (hour)",
              data: values,
              backgroundColor,
            },
          ],
        };
      }
    }

    if (getEmployeeWeeklyData) {
      weeklyValues = _.map(getEmployeeWeeklyData?.[0], (w) => w?.value);
      weeklyLabels = _.map(getEmployeeWeeklyData?.[0], (w) => w?.label);
      if (weeklyValues && weeklyLabels) {
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
      }
    }
  },
};
</script>
