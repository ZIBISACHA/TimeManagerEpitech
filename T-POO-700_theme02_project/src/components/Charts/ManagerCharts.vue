<template>
  <div class="mainContainer">
    <h3>Team charts</h3>
    <div class="chart">
      <team-charts
        :teamID="1"
        :startDatetime="'2021-01-01 00:00:00'"
        :endDatetime="'2021-12-31 00:00:00'"
      />
    </div>
    <h3>My charts</h3>
    <employee-charts
      :employeeID="1"
      :startDatetime="'2021-01-01 00:00:00'"
      :endDatetime="'2021-12-31 00:00:00'"
      :type="'currentUser'"
    />
    <h3>Employee charts</h3>
    <employee-charts
      :employeeID="2"
      :startDatetime="'2021-01-01 00:00:00'"
      :endDatetime="'2021-12-31 00:00:00'"
      :type="'otherEmployee'"
    />
  </div>
</template>

<script>
import TeamCharts from "./TeamCharts.vue";
import EmployeeCharts from "./EmployeeCharts.vue";

export default {
  name: "ManagerCharts",
  components: { TeamCharts, EmployeeCharts },
  data: () => ({}),
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
}
</style>
