<template>
  <div class="container mt-6">
    <!-- DATA TABLE -->
    <v-data-table
      :headers="headers"
      :items="impfeintraege"
      :search="search"
      :custom-filter="filter"
      :disable-sort="true"
      group-by="zulassungsnummer"
      show-group-by
    >
      <template v-slot:item.actions="{ item }">
        <v-icon small class="mr-2"> mdi-pencil </v-icon>
        <v-icon small @click="showDeleteDialog(item)"> mdi-delete </v-icon>
      </template>
      <template v-slot:top="{ attrs, on }">
        <div class="mx-1">
          <h3>Mein Impfpass</h3>
          <div class="d-flex">
            <v-text-field
              v-model="search"
              label="Search"
              color="red darken-2"
              clearable
            ></v-text-field>
            <v-spacer></v-spacer>
            <v-btn
              small
              color="red darken-2"
              dark
              class="mb-2 font-weight-bold"
              v-bind="attrs"
              v-on="on"
              @click="showAddDialog"
            >
              Neuer Eintrag
            </v-btn>
          </div>
          <v-dialog v-model="addDialog" max-width="500px">
            <v-card>
              <v-card-title class="subtitle-1 mb-3">Add</v-card-title
              ><v-card-text class="pb-0">
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="6" class="py-0">
                      <v-select
                        :items="addSelection"
                        item-text="impfstoffname"
                        item-value="zulassungsnummer"
                        filled
                        label="Impfstoffname"
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="addItem.impfstoffzulassungsnummer"
                      ></v-select>
                    </v-col>
                    <v-col cols="12" sm="6" class="py-0">
                      <v-text-field
                        label="Chargennummer"
                        filled
                        required
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="addItem.chargennummer"
                        minlength="8"
                        maxlength="8"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" class="py-0">
                      <v-textarea
                        label="Patienteninfo"
                        filled
                        required
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="addItem.patienteninfo"
                      ></v-textarea>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-2" text @click="addDialog = false"
                  >Cancel</v-btn
                >
                <v-btn color="red darken-2" text @click="executeAddItem"
                  >OK</v-btn
                >
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <v-dialog v-model="deleteDialog" max-width="500px">
            <v-card>
              <v-card-title class="subtitle-1"
                >Delete
                {{
                  deleteItem
                    ? `${deleteItem.impfstoffname} (${deleteItem.zulassungsnummer})`
                    : 'Item'
                }}?</v-card-title
              >
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-2" text @click="deleteDialog = false"
                  >Cancel</v-btn
                >
                <v-btn color="red darken-2" text @click="executeDeleteItem"
                  >OK</v-btn
                >
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </div>
      </template>
    </v-data-table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      headers: [
        {
          text: 'Impfstoff',
          value: 'impfstoffname',
        },
        {
          text: 'Zulassung',
          value: 'zulassungsnummer',
        },
        {
          text: 'Charge',
          value: 'chargennummer',
        },
        {
          text: 'Impfdatum',
          value: 'impfdatum',
        },
        {
          text: 'Actions',
          value: 'actions',
          align: 'right',
        },
      ],
      search: '',
      addDialog: false,
      addItem: {
        impfstoffzulassungsnummer: '',
        chargennummer: '',
        patienteninfo: '',
      },
      addSelection: [],
      deleteDialog: false,
      deleteItem: null,
    };
  },
  props: {
    impfeintraege: {
      type: Array,
    },
  },
  methods: {
    filter(value, search) {
      return (
        value != null &&
        search != null &&
        typeof value === 'string' &&
        value.toString().toLowerCase().indexOf(search.toLowerCase()) !== -1
      );
    },
    async showAddDialog() {
      this.addDialog = true;
      try {
        const result = await axios({
          url: `http://localhost:3000/impfstoffe`,
          method: 'GET',
        });
        this.addSelection = result.data;
      } catch (error) {
        console.error('Fetch data error:', error);
      }
    },
    async executeAddItem() {
      try {
        await axios({
          url: `http://localhost:3000/impfeintraege`,
          method: 'POST',
          data: this.addItem,
        });
        this.addDialog = false;
        this.$emit('refresh');
      } catch (error) {
        console.error('Post data error:', error);
      }
    },
    showDeleteDialog(item) {
      this.deleteDialog = true;
      this.deleteItem = item;
    },
    async executeDeleteItem() {
      try {
        await axios({
          url: `http://localhost:3000/impfeintraege/${this.deleteItem.id}`,
          method: 'DELETE',
        });
        this.deleteDialog = false;
        this.$emit('refresh');
      } catch (error) {
        console.error('Delete data error:', error);
      }
    },
  },
};
</script>

<style scoped></style>
