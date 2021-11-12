<template>
    <div>
        <side-bar-component />
        <div class="all_user_list">
            <v-card class="user_list_card">
            <div id="notifikation"></div>
                <v-list>
                    <v-card class="listed_user" v-for="user in users" :key="user.id">
                        <v-list-item>
                            <v-list-item-title>
                                {{ user.username }}
                            </v-list-item-title>
                            <v-list-item-subtitle>
                                {{ user.email }}
                            </v-list-item-subtitle>
                            <v-btn class="btn update" v-on:click="updateUser(user.id)">
                                Update
                            </v-btn>
                            <v-btn class="btn delete" v-on:click="deleteUser(user.id)">
                                Delete
                            </v-btn>
                        </v-list-item>
                    </v-card>
                </v-list>
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
        this.getAllUsers();
    },
    data() {
        return {
            errors: [],
            username: [],
            email: [],
            id: [],
            users: []
        }
    },
    methods: {
        async getAllUsers() {
            axios.get('http://localhost:4000/api/users/', {'mode': 'cors'})
            .then(response => {
                this.users = response.data.data
                console.log(this.users);
            }).catch(err => {console.error(err)})
        },
        async updateUser(UserID) {
            this.$router.push({path: '/userinfo/' + UserID});
        },
        async deleteUser(UserID) {
            // alert("You want to delete user with ID " + UserID);
            if ( confirm("Do you want to delete user " + UserID + " ?") === true )
            {
                axios.delete('http://localhost:4000/api/users/' + UserID, {'mode': 'cors'})
                .then(() => {
                    /* TODO
                    
                    */
                    this.$notify({
                        title: 'Success',
                        text: 'User deleted',
                        type: 'success',
                        duration: 1000,
                    })
                    this.getAllUsers()
                    })
                .catch(err => {console.error(err)})
            }
        },
    }
}
</script>

<style scoped>
    .listed_user {
        padding: 1% 1% 1% 1%;
        margin: 1em 1em 1em 1em;
    }
    .listed_user:hover {
        background-color: rgba(128, 128, 128, 0.384);
        transition: All 0.3s ease-in-out;
    }
    .btn {
        margin: 0.5% 0.5% 0.5% 0.5%;
    }

    .update {
        color: blue;
    }
    .all_user_list {
        margin: 5%;
    }
    .user_list_card {
        margin-left: 5%;
    }
    .delete {
        color: red;
    }
</style>