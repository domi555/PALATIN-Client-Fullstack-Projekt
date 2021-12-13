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

      <v-spacer></v-spacer>

      <v-btn to="/" class="dark lighten-3 mr-2" active-class="red darken-4"
        >Pass</v-btn
      >
      <v-btn to="/edit" class="dark lighten-3" active-class="red darken-4"
        >Bearbeiten</v-btn
      >
    </v-app-bar>

    <v-main>
      <router-view
        :impfeintraege="impfeintraege"
        :impfstoffe="impfstoffe"
        @refresh="loadData"
      />
    </v-main>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  name: 'App',
  data: () => ({
    impfeintraege: [],
    impfstoffe: [],
  }),
  async created() {
    this.loadData();
    this.getImpfstoffe();
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
    async getImpfstoffe() {
      try {
        const result = await axios({
          url: `http://localhost:3000/impfstoffe`,
          method: 'GET',
        });
        this.impfstoffe = result.data;
      } catch (error) {
        console.error('Fetch data error:', error);
      }
    },
  },
};
</script>
