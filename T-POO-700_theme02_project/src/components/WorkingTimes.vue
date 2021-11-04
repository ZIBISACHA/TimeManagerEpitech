<template>
    <div class="container">
        <h3 class="p-3 text-center">User {{userID}} Working Times</h3>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Start</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="startTime in startList" :key="startTime.id">
                    <td></td>
                    <td>{{startTime}}</td>
                </tr>
                <br>
                <tr>
                    <th>End</th>
                </tr>
                <tr v-for="endTime in endList" :key="endTime.id">
                    <td></td>
                    <td>{{endTime}}</td>
                </tr>
            </tbody>
        </table>
        
    </div>    
</template>
<script>
import axios from 'axios'

export default {
    //props: ['user_id'],
    created() {
        //console.log(this.$route.params.id);
        this.getWorkingTimes();
    },
    setup() {
    },
     data() {
         return {
            start: String,
            end: String,
            userID: Number,
            startList: [],
            endList: []
   }
 },

 methods: {
    async getWorkingTimes() {
    axios.get('http://localhost:4000/api/workingtimes/' + this.$route.params.userID + "?start=" + "1000-01-01 00:00:00" + "&end=" + "4000-01-01 00:00:00", {'mode': 'cors'})
    .then(response => {
        this.userID = this.$route.params.userID
        console.log("JSON: ", response.data.data);
        let wTimesArrayLength = response.data.data.length
        for (let i = 0; i < wTimesArrayLength; i++) {
          this.startList.push(response.data.data[i]['start']);
          this.endList.push(response.data.data[i]['end']);
        }
    }).catch(err => {
        console.log("ERREUR:", err);
    })
    
    },
 }
}
</script>

<style scoped>
</style>