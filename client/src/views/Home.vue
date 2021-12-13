<template>
  <v-container>
    <div v-for="k of impfstoffe" :key="k.id">
      <h3 class="mt-2 ml-2">
        Impfstoff:
        <span class="font-weight-medium">{{ k.impfstoffname }}</span>
      </h3>

      <div class="d-flex flex-wrap justify-start align-start">
        <v-card v-for="i of filter(k)" :key="i.id" class="ma-2" width="300">
          <v-card-text>
            <div>{{ i.impfstoffname }}</div>
            <p class="text-h6 font-weight-bold red--text text--darken-1 mb-1">
              {{ i.impfstoffzulassungsnummer }}
            </p>
            <p class="mb-1">{{ i.chargennummer }}</p>
            <p class="font-weight-bold mb-0">
              Datum: <span class="font-weight-medium">{{ i.impfdatum }}</span>
            </p>
          </v-card-text>
        </v-card>
        <p v-if="filter(k).length == 0" class="ml-3">Nicht bekannt.</p>
      </div>
    </div></v-container
  >
</template>

<script>
export default {
  props: {
    impfeintraege: {
      type: Array,
    },
    impfstoffe: {
      type: Array,
    },
  },
  methods: {
    filter(k) {
      return this.impfeintraege.filter(
        (el) => el.impfstoffzulassungsnummer == k.zulassungsnummer,
      );
    },
  },
};
</script>

<style lang="scss" scoped></style>
