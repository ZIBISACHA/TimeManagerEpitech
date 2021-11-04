<template>
    <div>
        <form
            id="user_management"
            @submit="createUser"
        >
        <p v-if="errors.length">
            <b>Please correct the following error(s):</b>
            <ul>
                <li v-for="err in errors" v-bind:key="err">{{ err }}</li>
            </ul>
        </p>
        <p>
            <label for="username">Username</label>
            <input type="text" name="username" id="username" v-model="username">
        </p>
        <p>
            <label for="email">Email</label>
            <input type="text" name="email" id="email" v-model="email">
        </p>
        <p>
            <input type="submit" value="Submit">
        </p>
        </form>
    </div>    
</template>

<script>
import axios from 'axios'

export default {
    created() {
        this.getUser();
    },
    setup() {
    },
    data() {
        return {
            errors: [],
            username: null,
            email: null,
            userID: null
            }
    },
    methods: {
        createUser(e) {
            e.preventDefault();
            var data = JSON.stringify({
                "user": {
                    "username": this.username,
                    "email": this.email
                    }
                    });
            axios.post('http://localhost:4000/api/users/', data, {headers: {'Content-Type': 'application/json'}})
            .then(res => {console.log(res);})
            .catch(err => {console.error(err);})
                    },
        async getUser() {
            axios.get('http://localhost:4000/api/users/' + this.$route.params.id, {'mode': 'cors'})
            .then(response => {
                this.userID = response.data.data['id']
                this.username = response.data.data['username']
                this.email = response.data.data['email']
                })
            .catch(err => {console.error(err)})
        },
        async deleteUser() {
            axios.delete('http://localhost:4000/api/users/' + this.$route.params.id, {'mode': 'cors'})
            .then(response => {console.log(response)})
            .catch(err => {console.error(err)})
            },
        async updateUser() {
            var data = JSON.stringify({
                "user": {
                    "username": "updated",
                    "email": "updated@updated.fr"
                    }
                    });
            axios.put('http://localhost:4000/api/users/' + this.$route.params.id, data, {headers: {'Content-Type': 'application/json'}}, {'mode': 'cors'})
            .then(res => {console.log(res)})
            .catch(err => {console.error(err)})
        }
 }
}
</script>



<style scoped>
</style>