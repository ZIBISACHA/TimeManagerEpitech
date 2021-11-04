<template>
    <div>
        <side-bar-component />
        <div>
            <v-card class="all_user_list">
                <v-list>
                    <v-card class="listed_user">
                        <v-list-item>
                            <v-list-item-title>
                                <!-- {{ Username }} -->
                                Jon Doe
                            </v-list-item-title>
                            <v-list-item-subtitle>
                                <!-- {{ email }} -->
                                jon@doe.fr
                            </v-list-item-subtitle>
                            <v-btn class="btn update">
                                Update
                            </v-btn>
                            <v-btn class="btn">
                                Delete
                            </v-btn>
                        </v-list-item>
                    </v-card>
                    <v-card class="listed_user">
                        <v-list-item>
                            <v-list-item-title>
                                <!-- {{ Username }} -->
                                Sacha Zibi
                            </v-list-item-title>
                            <v-list-item-subtitle>
                                <!-- {{ email }} -->
                                sacha@zibi.fr
                            </v-list-item-subtitle>
                            <v-btn class="btn update">
                                Update
                            </v-btn>
                            <v-btn class="btn">
                                Delete
                            </v-btn>
                        </v-list-item>
                    </v-card>
                    <v-card class="listed_user">
                        <v-list-item>
                            <v-list-item-title>
                                <!-- {{ Username }} -->
                                Hello World
                            </v-list-item-title>
                            <v-list-item-subtitle>
                                <!-- {{ email }} -->
                                hello@world.fr
                            </v-list-item-subtitle>
                            <v-btn class="btn update">
                                Update
                            </v-btn>
                            <v-btn class="btn">
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
import SideBarComponent from './SideBarComponent.vue'
// import UserComponent from './UserComponent.vue'

export default {
    components: {
        // UserComponent,
        SideBarComponent,
    },
    setup() {
        this.$emit("");
    },
    data() {
        return {
            errors: [],
            username: [],
            email: [],
            id: [],
        }
    },
    methods: {
    }
}
</script>

<style scoped>
    .listed_user {
        padding: 1% 1% 1% 1%;
        margin: 1%;
    }
    .btn {
        margin: 0.5%;
    }

    .update {
        color: blue;
    }
</style>