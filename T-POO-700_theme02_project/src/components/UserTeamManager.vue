<template>
    <div>
        <side-bar-component />
        <h1> <span> {{this.teamname}} </span> Management</h1>
        <v-divider></v-divider>
        <v-btn class="join_btn" v-on:click="joinToTeam">Join team</v-btn>
        <v-btn class="quit_btn" v-on:click="quitTeam">quit team</v-btn>
        <div class="userlist_div">
            <v-card v-for="user_ in userList" :key="user_.id" class="user_in_team_name" >
                <v-card-title> {{user_.username}} </v-card-title>
            </v-card>
        </div>
        <side-bar-component />
    </div>
</template>

<script>
import axios from 'axios'
import SideBarComponent from './SideBarComponent.vue';

export default {
    components: { SideBarComponent },
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
            console.log(this.$route.params.teamID);
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            axios.get('http://localhost:4000/api/team/' + this.$route.params.teamID, config)
            .then(response => {
                this.teamname = response.data.data['name']
            })
            .catch(err => {
                console.log(err);
            })
        },
        async getTeamUsers() {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            axios.get('http://localhost:4000/api/userTeams/team/' + this.$route.params.teamID, config)
            .then(response => {
                this.userList = response.data.users
            })
            .catch(err => {
                console.log(err);
            })
        },
        async joinToTeam() {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            this.userList.forEach(element => {
                if (element.id == localStorage.getItem("userID")) {
                    this.$notify({
                        title: 'Warning',
                        text: "You're already in this Team",
                        type: 'warn',
                        duration: 1500,
                    })
                    throw new Error("Already in this Team :(")
                }
            });
            var data = JSON.stringify({
                "user__team": {
                    "user_id": localStorage.getItem("userID"),
                    "team_id": this.teamID,
                }
            });
            await axios.post('http://localhost:4000/api/userTeams/', data, config)
            this.$notify({
                title: 'Success',
                text: 'Team Joined',
                type: 'success',
                duration: 1000,
            })
            this.getTeamUsers()
        },
        async quitTeam() {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            var userID = localStorage.getItem("userID");
            await axios.delete("http://localhost:4000/api/userTeams/user/" + userID + "/" + this.$route.params.teamID, config)
            .then(response => {
                console.log(response);
                this.$notify({
                    title: 'Success',
                    text: 'Team Quitted',
                    type: 'success',
                    duration: 1000,
                })
                this.getTeamUsers()
            })
            .catch(err => {
                console.log(err);
            })
        }
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
    .quit_btn {
        height: 2em;
        width: 17em;
        margin: 5em;
    }
</style>