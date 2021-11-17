<template>
  <div>
    <h1>Create Your Team</h1>
    <div>
      <form action="">
          <label for="teamname" id="teamname_label">Title</label>
          <input type="text" id="teamname_input" v-model="teamname">
          <v-btn id="submit_team" v-on:click="createTeam"> Submit </v-btn>
      </form>
    </div>
    <v-divider class="mx-4"/>
    <div class="teams_list">
        <v-card class="team_item" v-for="team in existing_teams" :key="team.id">
            <div class="team_name">
                <v-card-title class="team_name_" v-on:click="redirectTeamInfo(team.id)"> {{ team.name }} </v-card-title>
                <v-card-subtitle> {{ count_members(team.id) }} members </v-card-subtitle>
                <v-btn class="vdelete_btn" elevation="3" icon large v-on:click="deleteTeam(team.id)">
                    <img class="delete_btn_" src="../../public/delete.png">
                </v-btn>
            </div>
        </v-card>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
    created() {
        this.list_teams();
    },
    data() {
        return {
            teamname: null,
            existing_teams: [],
            size: null,
        }
    },
    methods: {
        async list_teams() {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user
                }
            }
            axios.get('http://localhost:4000/api/teams', config)
            .then(response => {
                this.existing_teams = response.data.data
            })
            .catch(err => {
                console.log(err);
            })
        },
        async createTeam() {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            var data = JSON.stringify({
                "team": {
                    "name": this.teamname,
                    }
                    });
            axios.post('http://localhost:4000/api/teams', data, config)
            .then(response => {
                console.log(response.status)
                this.$notify({
                        title: 'Success',
                        text: "Team " + this.teamname + " created !",
                        type: 'success',
                        duration: 1500,
                    })
                this.list_teams();
            })
            .catch(err => {
                console.log(err);
            })
        },
        async redirectTeamInfo(teamID) {
            this.$router.push({path: '/teaminfo/' + teamID});
        },
        count_members(teamID) {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            axios.get('http://localhost:4000/api/userTeams/team/' + teamID, config)
            .then(res => {
                console.log(Object.keys(res.data.users).length);
            })
            .catch(err => {
                console.log(err);
            })
            return "{J'arrive pas a afficher le nombre}";
        },
        deleteTeam(teamID) {
            const config = {
                mode: "cors",
                headers: {
                "Authorization": "Bearer " + localStorage.user,
                'Content-Type': 'application/json'
                }
            }
            axios.delete("http://localhost:4000/api/teams/" + teamID, config)
            .then(res => {
                console.log(res);
                this.$notify({
                    title: 'Success',
                    text: "Team " + this.teamname + " deleted !",
                    type: 'success',
                    duration: 1500,
                })
                this.list_teams();
            })
            .catch(err => {
                this.$notify({
                    title: 'Warning',
                    text: "Unable to delete " + this.teamname + ". Delete all users first !",
                    type: 'warn',
                    duration: 2500,
                })
                console.log(err);
            })
        }
    }
}
</script>

<style>
    #teamname_input {
        margin: auto;
        padding: 0.125em;
        border: solid 1px black;
    }
    #teamname_label {
        margin: auto;
        padding: 0.5em;
    }
    #submit_team {
        margin: 0.250em;
        padding: 0.125em 0.5em;

        border: solid 1px black;
    }
    #submit_team:hover {
        cursor: default;
        color: whitesmoke;
        background: black;
    }
    .teams_list {
        margin: 2.125em;
        /* border: solid 1px black; */
    }
    .team_name {
        padding: 0.125em;
    }
    .team_name_ {
        justify-content: center;
    }
    .team_item {
        margin: 0.250em;
    }
    .team_item:hover {
        cursor: default;
        background-color: whitesmoke;
        transition: All 0.2s ease-in-out;
    }
    .delete_btn_ {
        width: 1.975em;
        height: 1.975em;
    }
    .vdelete_btn {
        position: right;
    }
</style>