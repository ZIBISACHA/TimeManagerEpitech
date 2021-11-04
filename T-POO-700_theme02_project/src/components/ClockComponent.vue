<template>
    
        <v-card elevation="12" max-width="23%">
            <h4 class="display-3">
                <span>{{dozenHours}}</span>
                <span>{{hours}}</span>
                <span>:</span>
                <span>{{dozenMinute}}</span>
                <span>{{minute}}</span>
                <span>:</span>
                <span>{{dozenSeconde}}</span>
                <span>{{seconde}}</span>
                <v-btn
                    class="ma-2"
                    text
                    icon
                    @click="clock"
                >
                    <v-icon size="50" v-if="!clockIn">mdi-play</v-icon>
                    <v-icon v-else>mdi-pause</v-icon>
                </v-btn>
            </h4>  
        </v-card>
     
</template>
<script>
import axios from 'axios'

export default {
    setup() {
    },
     data() {
         return {
            username: String,
            startDateTime: null,
            clockIn: false,
            timer: 0,
            dozenSeconde: 0,
            seconde: 0,
            dozenMinute: 0,
            minute: 0,
            dozenHours: 0,
            hours: 0,
   }
 },
 methods: {
    clock() {
      if(!this.clockIn) {
        this.clockIn = !this.clockIn
        this.setTime()
        this.startDateTime = new Date();
        axios.post('http://localhost:4000/api/clocks/'+this.$route.params.username,{
            clock : {
                time: this.startDateTime,
                status: true
            },
            workingtimes : {
                start: this.startDateTime,
                end: this.startDateTime
            }
        }, {'mode': 'cors'})
        .then(response => {
            this.startDateTime = response.data.workingtime.start
            console.log(response)
        }).catch(err => {
            console.log(err)
        });
      } else {
        clearTimeout(this.timer)
        var dateEnd = new Date(this.startDateTime);
        if(this.seconde > 0) {
            dateEnd.setSeconds(dateEnd.getSeconds() + this.seconde);
        }
        if(this.dozenSeconde > 0) {
            var seconde = this.dozenSeconde * 10;
            dateEnd.setSeconds(dateEnd.getSeconds() + seconde);
        }
        if(this.minute > 0) {
            dateEnd.setMinutes(dateEnd.getMinutes() + this.minute);
        }
        if(this.dozenMinute > 0) {
            var minute = this.dozenMinute * 10;
            dateEnd.setMinutes(dateEnd.getMinutes() + minute);
        }
        if(this.hours > 0) {
            dateEnd.setHours(dateEnd.getHours() + this.hours);
        }
        if(this.dozenHours > 0) {
            var hours = this.dozenHours * 10;
            dateEnd.setHours(dateEnd.getHours() + hours);
        }
        dateEnd.setHours(dateEnd.getHours() + 1);
        axios.post('http://localhost:4000/api/clocks/'+this.$route.params.username,{
            clock : {
                status: false
            },
            workingtimes : {
                end: dateEnd
            }
        }, {'mode': 'cors'})
        .then(response => {
            console.log(response)
            this.refresh()
        }).catch(err => {
            console.log(err)
        });
      } 
    },
    refresh() {
        this.seconde = 0;
        this.dozenSeconde = 0;
        this.minute = 0;
        this.dozenMinute = 0;
        this.hours = 0;
        this.dozenHours = 0;
        this.clockIn = !this.clockIn
    },
    setTime() {
        this.seconde += 1;
        if(this.seconde > 9) {
            this.seconde = 0;
            this.dozenSeconde += 1;
        }
        if(this.dozenSeconde > 5) {
            this.dozenSeconde = 0;
            this.minute += 1;
        }
        if(this.minute > 9) {
            this.minute = 0;
            this.dozenMinute += 1;
        }
        if(this.dozenMinute > 5) {
            this.dozenMinute = 0;
            this.hours += 1;
        }
        if(this.hours > 9) {
            this.hours = 0;
            this.dozenHours += 1;
        }
        this.timer = setTimeout(() => {
            this.setTime()
        },1000)
    }
 }
}
</script>

<style scoped>
button {
    margin: 1%;
    width: 10%;
}
.clock {
    background-color: whitesmoke;
    margin: 5%;
    border-radius: 10px;
}
</style>