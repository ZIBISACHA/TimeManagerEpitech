<template>
<div>
    <side-bar-component />
    <div>
        <v-card class="card_style">
            <v-card-title class="card_title">
                User Info
                <v-icon aria-hidden="false">mdi-account</v-icon>
            </v-card-title>
            <v-card-subtitle> You can update your informations here  </v-card-subtitle>
            <v-divider class="mx-4"/>
            <div>
                <form id="user_management" @submit="updateUser">
                    <p>
                        <label for="username">Username</label>
                        <input class="input_" type="text" name="username" id="username" v-model="username">
                    </p>
                    <p>
                        <label for="email">Email</label>
                        <input class="input_" type="text" name="email" id="email" v-model="email">
                    </p>
                    <p id="roleman">
                        <label for="email">Role</label>
                        <!-- <input type="text" name="role" id="role" v-model="role"> -->
                        <select name="role" id="role" v-model="role">
                            <option value="3">Employee</option>
                            <option value="1">Manager</option>
                            <option value="2">Admin</option>
                        </select>
                    </p>
                    <input type="submit" value="Submit" id="submit_btn">
            </form>

            </div>
        </v-card>
    </div>
</div>
</template>

<script>
import axios from 'axios'
import SideBarComponent from './SideBarComponent.vue'

export default {
    components: {
        SideBarComponent,
    },
    created() {
        this.handleSelect()
        axios.get('http://localhost:4000/api/users/' + this.$route.params.UserID, {'mode': 'cors'})
        .then(response => {
            this.userID = response.data.user['id']
            this.username = response.data.user['username']
            this.email = response.data.user['email']
            this.role = response.data.role['id']
            })
        .catch(err => {console.error(err)})
    },
    data() {
        return {
            userID: null,
            email: null,
            username: null,
            role: null,
            teams: null,
        }
    },
    methods: {
        handleSelect() {
            
        },
        updateUser(e) {
            e.preventDefault();
            var data = JSON.stringify({
                    "user": {
                        "username": this.username,
                        "email": this.email,
                        "roles_id": this.role,
                        }
                        });
                axios.put('http://localhost:4000/api/users/' + this.$route.params.UserID, data, {headers: {'Content-Type': 'application/json'}}, {'mode': 'cors'})
                .then(res => {
                    console.log(res)
                    this.$notify({
                            title: 'Success',
                            text: 'User updated',
                            type: 'success',
                            duration: 1500,
                        })
                    })
                .catch(err => {console.error(err)})
        }
    }
}
</script>

<style>
    .card_style {
        margin: 10em;
        width: 50em;
        height: 50em;
    }
    .card_title {
        /* width: 10%;
        height: 10%; */
        /* text-align: center; */
    }
    #role {
        margin-top: 0.25em;
        margin-left: 1em;
        padding: 0.125em 1em;
        width: 6em;
        border: solid 1px black;
    }
    #email {
        padding: 0.125em 1em;
        margin-top: 0.25em;
        margin-left: 1em;

        border: solid 1px black;
    }
    #username {
        padding: 0.125em 1em;
        margin-top: 0.25em;
        margin-left: 1em;

        border: solid 1px black;
    }
    .submit_btn {
        border: solid 1px black;
    }
</style>