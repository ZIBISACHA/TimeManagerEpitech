<template>
  <div>
    <VueCtkDateTimePicker
      v-model="start"
      locale="fr"
      format="YYYY-MM-DD HH:mm:ss"
      output-format="YYYY-MM-DD HH:mm:ss"
      button-now-translation="Maintenant"
      label="Sélectionner une date de début"
    />
    <VueCtkDateTimePicker
      v-model="end"
      locale="fr"
      format="YYYY-MM-DD HH:mm:ss"
      output-format="YYYY-MM-DD HH:mm:ss"
      button-now-translation="Maintenant"
      label="Sélectionner une date de fin"
    />
    <button
      @click="
        createWorkingTime({
          workingtime: {
            start,
            end,
          },
        })
      "
      v-if="this.$route.query.type == 'creation'"
    >
      Ajouter un workingtime
    </button>
    <button
      @click="
        updateWorkingTime({
          workingtime: {
            start,
            end,
          },
        })
      "
      v-if="this.$route.query.type == 'update'"
    >
      Modifier le workingtime
    </button>

    <button @click="deleteWorkTime" v-if="this.$route.query.type == 'del'">
      Supprimer le workingtime
    </button>
  </div>
</template>

<script>
import axios from "axios";
import Vue from "vue";
import VueCtkDateTimePicker from "vue-ctk-date-time-picker";
import "vue-ctk-date-time-picker/dist/vue-ctk-date-time-picker.css";

Vue.component("VueCtkDateTimePicker", VueCtkDateTimePicker);

export default {
  created() {
    if(this.$route.query.type !== "creation"){
      this.getWorkingTime();
    }
  },
  setup() {},
  data() {
    return {
      start: "2021-10-28 12:00:00",
      end: "2021-10-28 12:00:00",
      type: String,
      workingtimeId: String,
    };
  },

  methods: {
    getWorkingTime: function () {
      axios
        .get(
          "http://localhost:4000/api/workingtimes/" +
            this.$route.params.userID + "/" + this.$route.params.workingtimeid,
          { mode: "cors" }
        )
        .then((response) => {
          this.start = response.data.data["start"];
          this.end = response.data.data["end"];
          console.log(response)
        })
        .catch((err) => {
          console.log(err);
        });
    },
    createWorkingTime: function (workingTime) {
      console.log("i'm a function");
      axios
        .post(
          "http://localhost:4000/api/workingtimes/" + this.$route.params.userID,
          workingTime,
          { mode: "cors" }
        )
        .then((response) => (this.workingtimeId = response.data.id))
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
    deleteWorkTime: function () {
      console.log("i'm a deleting function");
      axios
        .delete(
          "http://localhost:4000/api/workingtimes/" +
            this.$route.params.workingtimeid,
          { mode: "cors" }
        )
        .then((response) => console.log(response))
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
      this.$router.push({ name: "About" });
    },
    updateWorkingTime: function (workingTime) {
      axios
        .put(
          "http://localhost:4000/api/workingtimes/" +
            this.$route.params.workingtimeid,
          workingTime,
          { mode: "cors" }
        )
        .then((response) => (this.workingtimeId = response.data.id))
        .catch((error) => {
          this.errorMessage = error.message;
          console.error("There was an error!", error);
        });
    },
  },
};
</script>

<style scoped></style>
