<template>
  <v-container>
    <h3 class="ml-2 pt-5">Mein Impfpass</h3>
    <div
      v-for="impfstoff of impfstoffe"
      :key="impfstoff.id"
      v-show="filterImpfeintraege(impfstoff).length != 0"
    >
      <h4 class="mt-2 ml-2">
        Impfstoff:
        <span class="font-weight-medium">{{ impfstoff.impfstoffname }}</span>
      </h4>

      <div class="d-flex flex-wrap justify-start align-start">
        <v-card
          v-for="impfeintrag of filterImpfeintraege(impfstoff)"
          :key="impfeintrag.id"
          class="ma-2"
          width="300"
        >
          <v-card-text>
            <div class="black--text font-weight-bold">
              {{ impfeintrag.impfstoffname }}
            </div>
            <p class="text-h6 font-weight-bold red--text text--darken-1 mb-1">
              {{ impfeintrag.impfstoffzulassungsnummer }}
            </p>
            <p class="black--text mb-1">{{ impfeintrag.chargennummer }}</p>
            <p class="black--text darken font-weight-bold mb-0">
              Datum:
              <span class="font-weight-medium">{{
                impfeintrag.impfdatum
              }}</span>
            </p>
          </v-card-text>
        </v-card>
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
    filterImpfeintraege(i) {
      return this.impfeintraege.filter(
        (el) => el.impfstoffzulassungsnummer == i.zulassungsnummer,
      );
    },
  },
};
</script>

<style lang="scss" scoped></style>
