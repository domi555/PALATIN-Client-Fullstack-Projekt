<template>
  <v-container class="mt-6">
    <!-- DATA TABLE -->
    <v-data-table
      :headers="headers"
      :items="impfeintraege"
      :search="search"
      :custom-filter="filter"
      :disable-sort="true"
      group-by="impfstoffzulassungsnummer"
      show-group-by
    >
      <template v-slot:top="{ attrs, on }">
        <div class="mx-1">
          <h3>Impfpassverwaltung</h3>

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

          <!-- Add Dialog -->
          <v-dialog v-if="addItem" v-model="addDialog" max-width="500px">
            <v-card>
              <v-card-title class="subtitle-1 mb-3">Neuer Eintrag</v-card-title
              ><v-card-text class="pb-0">
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="6" class="py-0">
                      <v-select
                        :items="impfstoffe"
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
                        maxlength="10"
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
                  >Abbrechen</v-btn
                >
                <v-btn color="red darken-2" text @click="executeAddItem"
                  >Erstellen</v-btn
                >
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <!-- Update Dialog -->
          <v-dialog v-if="updateItem" v-model="updateDialog" max-width="500px">
            <v-card>
              <v-card-title class="subtitle-1 mb-3"
                >Eintrag aktualisieren</v-card-title
              ><v-card-text class="pb-0">
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="6" class="py-0">
                      <v-select
                        :items="impfstoffe"
                        item-text="impfstoffname"
                        item-value="zulassungsnummer"
                        filled
                        label="Impfstoffname"
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="updateItem.impfstoffzulassungsnummer"
                      ></v-select>
                    </v-col>
                    <v-col cols="12" sm="6" class="py-0">
                      <v-text-field
                        label="Chargennummer"
                        filled
                        required
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="updateItem.chargennummer"
                        maxlength="10"
                      ></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="12" class="py-0">
                      <v-textarea
                        label="Patienteninfo"
                        filled
                        required
                        color="red darken-2"
                        class="pt-0 mt-0"
                        v-model="updateItem.patienteninfo"
                      ></v-textarea>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-2" text @click="updateDialog = false"
                  >Abbrechen</v-btn
                >
                <v-btn color="red darken-2" text @click="executeUpdateItem"
                  >Speichern</v-btn
                >
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <!-- Delete Dialog -->
          <v-dialog v-if="deleteItem" v-model="deleteDialog" max-width="500px">
            <v-card>
              <v-card-title class="subtitle-1"
                >Löschen:
                {{
                  `${deleteItem.impfstoffname} (${deleteItem.impfstoffzulassungsnummer})`
                }}</v-card-title
              >
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="red darken-2" text @click="deleteDialog = false"
                  >Abbrechen</v-btn
                >
                <v-btn color="red darken-2" text @click="executeDeleteItem"
                  >Löschen</v-btn
                >
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </div>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon small @click="showUpdateDialog(item)" class="mr-2">
          mdi-pencil
        </v-icon>
        <v-icon small @click="showDeleteDialog(item)"> mdi-delete </v-icon>
      </template>
    </v-data-table>
  </v-container>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      headers: [
        {
          text: 'Impfstoff: ',
          value: 'impfstoffname',
        },
        {
          text: 'Zulassung: ',
          value: 'impfstoffzulassungsnummer',
        },
        {
          text: 'Charge: ',
          value: 'chargennummer',
        },
        {
          text: 'Impfdatum: ',
          value: 'impfdatum',
        },
        {
          text: 'Actions',
          value: 'actions',
          align: 'right',
        },
      ],
      search: '',

      // Add Dialog
      addDialog: false,
      addItem: {
        impfstoffzulassungsnummer: '',
        chargennummer: '',
        patienteninfo: '',
      },
      // Update Dialog
      updateDialog: false,
      updateItem: null,
      // Delete Dialog
      deleteDialog: false,
      deleteItem: null,
    };
  },
  props: {
    impfeintraege: {
      type: Array,
    },
    impfstoffe: {
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
    // Add Dialog
    async showAddDialog() {
      this.addDialog = true;
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

        this.addItem.impfstoffzulassungsnummer = '';
        this.addItem.chargennummer = '';
        this.addItem.patienteninfo = '';
      } catch (error) {
        console.log('Post data error:', error);
      }
    },
    // Update Dialog
    async showUpdateDialog(item) {
      this.updateDialog = true;
      this.updateItem = { ...item };
    },
    async executeUpdateItem() {
      try {
        await axios({
          url: `http://localhost:3000/impfeintraege/${this.updateItem.id}`,
          method: 'PATCH',
          data: {
            impfstoff_zulassungsnummer:
              this.updateItem.impfstoffzulassungsnummer,
            chargennummer: this.updateItem.chargennummer,
            patienteninfo: this.updateItem.patienteninfo,
          },
        });
        this.updateDialog = false;
        this.$emit('refresh');
      } catch (error) {
        console.log('Update data error:', error);
      }
    },
    // Delete Dialog
    showDeleteDialog(item) {
      this.deleteDialog = true;
      this.deleteItem = { ...item };
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
        console.log('Delete data error:', error);
      }
    },
  },
};
</script>

<style scoped></style>
