<template>
    <div>
        <p>Météo actuelle à {{  city.name }}</p>
        <p>Température: {{  city.celcius }}</p>
        <p>Date {{  city.date }}</p>
    </div>    
</template>

<script>
export default {
    setup() {
        
    },
     data() {
         return {
            city: {
                name: 'Lyon',
                celcius: '23°',
                date: Date()
     }
   }
 },
 methods: {
     /* async */ RandomTemp() {
         this.city.celcius = ((Math.random()%40)+1).toString();
        //  return ((rand()%40)+1).toString();
     }

 }
}
</script>

<style scoped>

</style>