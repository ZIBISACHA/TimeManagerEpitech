<template>
    <div>
        <h1> <span> {{this.teamname}} </span> Management</h1>
        <v-divider></v-divider>
        <v-btn class="join_btn" v-on:click="joinToTeam">Join team</v-btn>
        <div class="userlist_div">
            <v-card v-for="user_ in userList" :key="user_.id" class="user_in_team_name" >
                <v-card-title> {{user_.username}} </v-card-title>
            </v-card>
        </div>      
    </div>
</template>

<script>
import axios from 'axios'

export default {
    setup() {
    },
    created() {
        this.getTeamInfo();
        this.getTeamUsers();
    },
    data() {
        return {
            userList: [],
            teamname: null,
            teamID: this.$route.params.teamID,
        }
    },
    methods : {
        async getTeamInfo() {
            axios.get('http://localhost:4000/api/team/' + this.$route.params.teamID, {'mode': 'cors'})
            .then(response => {
                this.teamname = response.data.data['name']
            })
            .catch(err => {
                console.log(err);
            })
        },
        async getTeamUsers() {
            axios.get('http://localhost:4000/api/userTeams/team/' + this.$route.params.teamID, {'mode': 'cors'})
            .then(response => {
                this.userList = response.data.users
                console.log(response.data.users);
            })
            .catch(err => {
                console.log(err);
            })
        },
        async joinToTeam() {
            /* TODO 
            
                check si le user est déjà présent dans this.userList
            
            */
            if (this.userList.some(users => users.id === localStorage.getItem("userID")))
            {
                console.log("Déjà dedans gros !!")
            } else {
                console.log("Tu peux y aller mec")
            }
            var data = JSON.stringify({
                "user__team": {
                    "user_id": localStorage.getItem("userID"),
                    "team_id": this.teamID,
                }
            });
            await axios.post('http://localhost:4000/api/userTeams/', data, {headers: {'Content-Type': 'application/json'}})
            this.$notify({
                title: 'Success',
                text: 'Team Joined',
                type: 'success',
                duration: 1000,
            })
            this.getTeamUsers()
        },
    }
}
</script>

<style>
    .user_in_team_name {
        margin: 0.5em 0.125em;
        padding: 0.125em;
    }
    .join_btn {
        height: 2em;
        width: 17em;
        margin: 5em;
    }
</style>