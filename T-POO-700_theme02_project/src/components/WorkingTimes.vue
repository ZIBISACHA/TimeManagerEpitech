<template>
    <div class="container">
        <v-data-table
            :headers="headers"
            :items="wDates"
            :items-per-page="5"
            class="elevation-1"
        >
            <template v-slot:top>
                <v-toolbar-title>WORKING TIMES</v-toolbar-title>
            </template>
            <template v-slot:item.actions="{ item }">
                <v-icon
                small
                class="mr-2"
                @click="editItem(item)"
                >
                mdi-pencil
                </v-icon>
            </template>
            <template v-slot:no-data>
                <v-btn
                color="primary"
                @click="initialize"
                >
                Reset
                </v-btn>
            </template>
        </v-data-table>
    </div>    
</template>
<script>
import axios from 'axios';
import moment from "moment";

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
            endList: [],
            headers: [
                {
                    text: 'Start Date',
                    align: 'start',
                    sortable: false,
                    value: 'start',
                },
                {text: 'End Date', value:'end'},
                { text: 'Actions', value: 'actions', sortable: false },
            ],
            wDates: []
    }
 },

 props: {
     user: {
         type: Number,
         default: null
     }
 },

 methods: {
// ANCHOR
    async getWorkingTimes() {
        const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
        }
    axios.get(/*'http://localhost:4000/api/workingtimes/'*/'http://35.246.32.237:4000/api/workingtimes/' + this.user + "?start=" + "1000-01-01 00:00:00" + "&end=" + "4000-01-01 00:00:00", config)
    .then(response => {
        this.userID = this.user
        var wTimes = [];
        response.data.data.forEach(wTime => {
            wTimes.push ({
                start: moment(wTime.start).format("YYYY/MM/DD HH:mm:ss"),
                end: moment(wTime.end).format("YYYY/MM/DD HH:mm:ss"),
            })
        });
        this.wDates = wTimes;
    }).catch(err => {
        console.log("ERREUR:", err);
    })
    
    },
 }
}
</script>

<style scoped>
</style>