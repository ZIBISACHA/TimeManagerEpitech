<template>
  <div class="chart">
    <line-chart
      v-if="loaded"
      :chartdata="chartdata"
      :options="options"/>
    <doughnut-chart
      v-if="loaded"
      :chartdata="chartdata"
      :options="optionsCircle"/>
    <polar-area 
      v-if="loaded"
      :chartdata="chartdata"
      :options="optionsCircle"/>
    <bar-chart 
      v-if="loaded"
      :chartdata="chartdata"
      :options="options"
    />
  </div>
</template>

<script>
import LineChart from './LineChart.vue'
import DoughnutChart from './DoughnutChart.vue'
import axios from 'axios'
import PolarArea from './PolarArea.vue'
import BarChart from './BarChart.vue'

export default {
  name: 'LineChartContainer',
  components: { LineChart, DoughnutChart, PolarArea, BarChart },
  data: () => ({
    loaded: false,
    chartdata: null,
    clockData: {},
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
              padding: 20
            }
          }
        ]
      }
    }
  }),
  async mounted () {
    this.loaded = false
    const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
    try {
      axios.get('http://localhost:4000/api/clocks/1', config)
      .then(response => {
          var date = [];
          response.data.data.forEach(clock => {
            var time = new Date(clock.time);
            var month = time.getUTCMonth() + 1;
            var clockDate = time.getFullYear() + '-' +  month + '-' + time.getUTCDate();
            date.push(clockDate)
          });
          const counts = {};
          date.forEach(function (x) { counts[x] = (counts[x] || 0) + 1; });
          this.chartdata = {
            labels: Object.keys(counts),
            datasets: [
              {
                label: 'Nb utilisation clock',
                //backgroundColor: '#f87979',
                data: Object.values(counts),
                backgroundColor: [
                  'rgba(255, 99, 132, 0.4)',
                  'rgba(54, 162, 235, 0.4)',
                  'rgba(255, 206, 86, 0.4)',
                  'rgba(75, 192, 192, 0.4)',
                  'rgba(153, 102, 255, 0.4)',
                  'rgba(255, 159, 64, 0.4)'
                ],
              }]
          }
           this.loaded = true
      }).catch(err => {
          console.log(err);
      });
    } catch (e) {
      console.error(e)
    }
  }
}
</script>
<style>
  .chart {
    display: flex;
  };
</style>
