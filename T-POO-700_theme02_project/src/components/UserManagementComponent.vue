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
                    <!-- <p hidden="true">
                        <label for="email">Role</label>
                        <input type="text" name="role" id="role" v-model="role">
                    </p> -->
                    <input type="submit" value="Submit">
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
    data() {
        return {
            email: null,
            username: null,
            role: null,
            teams: null,
        }
    },
    created() {
        axios.get('http://localhost:4000/api/users/' + this.$route.params.UserID, {'mode': 'cors'})
        .then(response => {
            this.userID = response.data.user['id']
            this.username = response.data.user['username']
            this.email = response.data.user['email']
            })
        .catch(err => {console.error(err)})
    },
    methods: {
        updateUser(e) {
            alert("");
            e.preventDefault();
            var data = JSON.stringify({
                    "user": {
                        "username": this.username,
                        "email": this.email
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
    .input_ {

    }

    
</style>