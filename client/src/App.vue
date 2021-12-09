<template>
  <v-app>
    <v-app-bar app color="dark" dark>
      <div class="d-flex align-center">
        <v-img
          class="shrink mr-2"
          contain
          src="img/logo.png"
          alt="Vuetify Logo"
          width="40"
        />

        <h3 class="font-weight-regular ml-2">e-Impfpass</h3>
      </div>
    </v-app-bar>

    <v-main>
      <router-view :impfeintraege="impfeintraege" @refresh="loadData" />
    </v-main>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  name: 'App',
  data: () => ({
    impfeintraege: [],
  }),
  async created() {
    this.loadData();
  },
  methods: {
    async loadData() {
      try {
        const result = await axios({
          url: 'http://localhost:3000/impfeintraege',
          method: 'GET',
        });
        this.impfeintraege = result.data;
        this.impfeintraege.forEach(
          (el, i) =>
            (this.impfeintraege[i].impfdatum =
              new Date(el.impfdatum).getDate() +
              '.' +
              new Date(el.impfdatum).getMonth() +
              '.' +
              new Date(el.impfdatum).getFullYear()),
        );
      } catch (error) {
        console.error('Fetch data error:', error);
      }
    },
  },
};
</script>
