<template>
  <!-- <div>test</div> -->
  <div>
    <div id="app">
    <v-app id="inspire">
      <v-container>
        <v-row no-gutters>
          <v-col
            cols="12"
            sm="3"
          >
            <clock-component 
              id="clock"
              :userID="1" 
            />
          </v-col>
          <v-col
            cols="12"
            sm="3"
          >
            <v-card id="total">
              TOTAL HOURS WORKED <br> OF THE MONTH <br> {{this.timesWorked}}
            </v-card>
          </v-col>
          <v-col
            cols="12"
            sm="3"
          >
            <v-card id="total">
              TOTAL HOURS EVENING WORKED <br> OF THE MONTH <br> {{this.eveningWorked}}
            </v-card>
          </v-col>
          <v-col
            cols="12"
            sm="3"
          >
            <v-card id="total">
              TOTAL <br> WORKED<br> {{this.totalWorked}}
            </v-card>
          </v-col>
        </v-row>
      </v-container>
      <div id="chart">
        <v-row no-gutters>
          <v-col
              cols="12"
              sm="6"
            >
              <v-card max-width="95%"> 
                <line-chart
                v-if="loaded"
                :chartdata="this.getChartData().chartdata"
                :options="options"
              />
              </v-card>
          </v-col>
          <v-col
            cols="12"
            sm="6"
          >
            <v-card id="doughnut" > 
              <doughnut-chart
              v-if="loaded"
              :chartdata="this.getChartData().chartdata"
              :options="optionsCircle"
            />
            </v-card>
          </v-col>
        </v-row>
      </div>
      <div id="wTimes">
        <working-times 
          :user="1"
        />
      </div>
    </v-app>
    </div>
    <side-bar-component />  
  </div>
</template>

<script>
import axios from "axios";
import LineChart from "../components/LineChart.vue";
import moment from "moment";
import _ from "lodash";
import ClockComponent from "../components/ClockComponent.vue"
import WorkingTimes from "../components/WorkingTimes.vue"
import DoughnutChart from"../components/DoughnutChart.vue"
import SideBarComponent from '../components/SideBarComponent.vue'

export default {
  components: { LineChart, ClockComponent, SideBarComponent, DoughnutChart, WorkingTimes },

  mounted() {
    console.log(this.$vuetify.breakpoint.name)
    this.getWorkingTimes();
    this.getWorkingHours();
  },
  setup() {},
  data() {
    return {
      diff: Number,
      diffList: [],
      diffListAdded: [],
      timesWorked: 0,
      eveningWorked: 0,
      totalWorked: 0,
      loaded: true,
      chartdata: {},
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
                padding: 25,
              },
            },
          ],
        },
      },
    };
  },

  methods: {
    getDuration(start, end,format) {
      const duration = moment
        .duration(
          moment
            .utc(
              moment(end, "YYYY/MM/DD HH:mm:ss").diff(
                moment(start, "YYYY/MM/DD HH:mm:ss")
              )
            )
            .format("HH:mm:ss")
        )
      return format == "hour" ? duration.asHours() : duration.asMilliseconds()
    },
    async getWorkingTimes() {
      axios
        .get(
          //"http://localhost:4000/api/workingtimes/2" +
            "http://35.246.32.237:4000/api/workingtimes/1"+
            "?start=" +
            moment().startOf("month").format("YYYY-MM-DD HH:mm:ss").toString() + // get first day of current mounth
            "&end=" +
            moment().format("YYYY-MM-DD HH:mm:ss"), //now()
          { mode: "cors" }
        )
        .then((response) => {
          console.log(
            "moment",
            moment().endOf("month").format("YYYY-MM-DD HH:mm:ss").toString()
          );
          // get duration for every workingtime
          let wTimesArrayLength = response.data.data.length;
          console.log("data", response.data.data);
          for (let i = 0; i < wTimesArrayLength; i++) {
            this.diffList.push({
              duration: this.getDuration(
                response.data.data[i]["start"],
                response.data.data[i]["end"],
                "hour"
              ),
              startDate: moment(response.data.data[i]["start"]).format(
                "YYYY-MM-DD"
              ),
            });
          }
          // get all labels by day without duplications
          const workedDaysInMonthLabels = _(response.data.data)
            .map((d) => ({
              value: moment(d.start).format("YYYY-MM-DD"),
              label: moment(d.start).format("dddd"),
            }))
            .uniqBy("value")
            .orderBy("value", "asc")
            .value();

          const workedTimesInMonth = _(response.data.data)
            .map((d) => ({
              start: moment(d.start).format("YYYY-MM-DD HH:mm:ss"),
              end: moment(d.end).format("YYYY-MM-DD HH:mm:ss"),
              timeDiff: this.getDuration(
                d.start,
                d.end,
                "millisec"
              )
            }))
            .orderBy("value", "asc")
            .value();

          workedTimesInMonth.forEach(wTimes => {
            if(moment(wTimes.start).format('hh') > 7 && moment(wTimes.start).format('hh') < 19) {
              this.timesWorked += wTimes.timeDiff;
            }else{
              this.eveningWorked += wTimes.timeDiff;
            }

          });
          this.totalWorked = this.timesWorked + this.eveningWorked;
          if(this.totalWorked){
            this.totalWorked = moment(this.totalWorked).utc().format("hh:mm:ss");
          }
          if(this.timesWorked){
            this.timesWorked = moment(this.timesWorked).utc().format("hh:mm:ss");
          }
          if(this.eveningWorked){
            this.eveningWorked = moment(this.eveningWorked).utc().format("hh:mm:ss");
          }
          // group every workingdays of the same day
          const grouped = _(this.diffList)
            .groupBy((w) => w.startDate)
            .value();
          // sum the workinddays of the same day
          for (let y = 0; y < workedDaysInMonthLabels.length; y++) {
            const summedWorkingtime = _(
              grouped[workedDaysInMonthLabels[y]?.value]
            ).reduce((sum, n) => {
              return sum + n.duration;
            }, 0);
            // add the sum of workingtimes of the day in a list
            this.diffListAdded.push({
              value: summedWorkingtime,
              label: workedDaysInMonthLabels[y]?.label,
            });
          }
        })
        .catch((err) => {
          console.log("ERREUR:", err);
        });
    },
    getChartData() {
      let artificialArray = [];
      for (let y = 0; y < this.diffListAdded.length; y++){
        artificialArray.push(this.diffListAdded[y].label.toString())
      }
      console.log(artificialArray)
      if(artificialArray.length > 0) {
        return {
        chartdata: {
          labels:artificialArray, 
          datasets: [
            {
              label: "Heures travaillées ce mois-ci",
              data: _.map(this.diffListAdded, (w) => w.value),
              backgroundColor: [
                "rgba(255, 99, 132, 0.4)",
                "rgba(54, 162, 235, 0.4)",
                "rgba(255, 206, 86, 0.4)",
                "rgba(75, 192, 192, 0.4)",
                "rgba(153, 102, 255, 0.4)",
                "rgba(255, 159, 64, 0.4)",
                ],
              },
            ],
          },
        };
      }
    },
    getWorkingHours() {
      console.log(_(this.diffList).value())
    }
  },
};
</script>

<style scoped>
 
 @media (min-width: 1904px) {
  #chart {
   margin-top: 3%;
   margin-left: 15%;
  }

  #wTimes {
    margin-top: 3% ;
    margin-right: 3%;
  }

  #app {
    margin-top: 3%;
  }

  #total {
    max-width: 90%;
  }

  #doughnut {
    max-width: 59%;
  }

  #clock {
    margin-right: 10%;
  }
 }

 @media (max-width: 1904px) {
   @media (min-width: 961px)  {
       #chart {
      margin-top: 3%;
      margin-left: 10%;
      max-width: 95%;
      }

      #doughnut {
        max-width: 87%;
      }

      #total {
        max-width: 94%;
      }

      #clock {
        margin-right: 10%;
        margin-left: 20%;
      }

      #wTimes {
        max-width: 86%;
        margin-left: 9%;
      } 
   }
 }

 @media (max-width: 960px) {
   #wTimes {
     margin-bottom: 10%;
   }

   #chart {
    margin-left: 3%;
    width: 100%;
   }

   #doughnut {
    max-width: 95%;
    margin-top: 2%;
  }
 }

</style>
