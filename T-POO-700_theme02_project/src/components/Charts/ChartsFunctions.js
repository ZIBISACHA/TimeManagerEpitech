import axios from "axios";
import _ from "lodash";
import moment from "moment";

let chartDataFromJs = [];
let weeklyChartDataFromJs = [];
let employeeDailyChartDataFromJs = [];
let employeeWeeklyChartDataFromJs = [];
let currentUserDailyChartDataFromJs = [];
let currentUserWeeklyChartDataFromJs = [];

export const getTeamAverageWorkingtime = (isDaily, apiCall, type) => {
  try {
    axios
      .get(`${apiCall}`, { mode: "cors" })
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
        if (type === "team") {
          chartDataFromJs.push(averageByDay);
          weeklyChartDataFromJs.push(averageByWeek);
        } else if (type === "otherEmployee") {
          employeeDailyChartDataFromJs.push(averageByDay);
          employeeWeeklyChartDataFromJs.push(averageByWeek);
        }
        else {
         currentUserDailyChartDataFromJs.push(averageByDay);
         currentUserWeeklyChartDataFromJs.push(averageByWeek);
        }
      })
      .catch((err) => {
        console.log(err);
      });
  } catch (e) {
    console.error(e);
  }
  if (type === "team") {
    return isDaily ? chartDataFromJs : weeklyChartDataFromJs;
  }
  else if (type === "otherEmployee") {
    return isDaily ? employeeDailyChartDataFromJs : employeeWeeklyChartDataFromJs;
  }
  else {
    return isDaily ? currentUserDailyChartDataFromJs : currentUserWeeklyChartDataFromJs;
  }
};

const getAverageTime = (workingtimes, data, frequency) => {
  const numberOfWorkers = _(data)
    .map((w) => w.userID)
    .uniq()
    .value().length;
  const averageByDay = _(workingtimes)
    .map((w) => ({
      value: w.value / numberOfWorkers,
      label: w.label,
    }))
    .value();

  //----WEEK--------
  const labels = _(workingtimes)
    .map((w) => _.split(w.label, " ")[0])
    .uniq()
    .value();

  // group every workingtimes by month
  const grouped = _(workingtimes)
    .groupBy((w) => _.split(w.label, " ")[0])
    .value();
  // sum the workingtimes of the same month
  let averageByWeek = [];
  for (let y = 0; y < labels.length; y++) {
    const summedWorkingtime = _(grouped[labels[y]]).reduce((sum, n) => {
      return sum + n.value;
    }, 0);
    // add the sum of workingtimes of the month in a list
    averageByWeek.push({
      value: summedWorkingtime / 5,
      label: labels[y],
    });
  }
  return frequency == "daily" ? averageByDay : averageByWeek;
};

const getEveryDayWorkingtimes = (data) => {
  // get duration for every workingtime
  let wTimesArrayLength = data.length;
  let diffList = [];
  for (let i = 0; i < wTimesArrayLength; i++) {
    diffList.push({
      duration: getDuration(data[i]["start"], data[i]["end"]),
      startDate: moment(data[i]["start"]).format("YYYY-MM-DD"),
    });
  }
  // get all labels by day without duplications
  const workedDaysLabels = _(data)
    .map((d) => ({
      value: moment(d.start).format("YYYY-MM-DD"),
      label: moment(d.start).format("MMMM DD"),
    }))
    .uniqBy("value")
    .orderBy("value", "asc")
    .value();
  // group every workingdays of the same day
  const grouped = _(diffList)
    .groupBy((w) => w.startDate)
    .value();
  // sum the workinddays of the same day
  let diffListAdded = [];
  for (let y = 0; y < workedDaysLabels.length; y++) {
    const summedWorkingtime = _(grouped[workedDaysLabels[y]?.value]).reduce(
      (sum, n) => {
        return sum + n.duration;
      },
      0
    );
    // add the sum of workingtimes of the day in a list
    diffListAdded.push({
      value: summedWorkingtime,
      label: workedDaysLabels[y]?.label,
    });
  }
  return diffListAdded;
};

const getDuration = (start, end) => {
  return moment
    .duration(
      moment
        .utc(
          moment(end, "YYYY/MM/DD HH:mm:ss").diff(
            moment(start, "YYYY/MM/DD HH:mm:ss")
          )
        )
        .format("HH:mm:ss")
    )
    .asHours();
};
