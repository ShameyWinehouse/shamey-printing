<script>


import { format } from 'timeago.js';


class Page {
  constructor(url, altText, index) {
    this.url = url;
    this.altText = altText;
    this.index = index;
  }
}

export default {
  data() {
    return {
      config: null,
      locationId: "",
      viewCreate: false,
      viewCreateTypeAndArrangement: false,
      viewCreateDetailsAndPages: false,
      createType: "",
      createArrangement: undefined,
      pages: [],
      formAddPage: {
        url: "",
        alt: "",
      },
      dialogAddPage: false,
      printableTitle: "",
      printableDescription: "",

      maxNumPages: 20,

      createTypeRules: [
        value => {
          if (value) return true
          return 'Type is required.'
        },
      ],
      createArrangementRules: [
        value => {
          if (value) return true
          return 'Layout arrangement is required.'
        },
      ],

      printableTitleRules: [
        value => {
          if (value) return true
          return 'Title is required.'
        },
        value => {
          if (value?.length <= 50) return true
          return 'Title must be less than 50 characters.'
        },
        value => {
          if (value?.length >= 10) return true
          return 'Title must be more than 10 characters.'
        },
      ],
      printableDescriptionRules: [
        value => {
          if (value) return true
          return 'Description is required.'
        },
        value => {
          if (value?.length <= 100) return true
          return 'Description must be less than 100 characters.'
        },
        value => {
          if (value?.length >= 10) return true
          return 'Description must be more than 10 characters.'
        },
      ],


      pageUrlRules: [
        value => {
          console.log('foo', value);
          if (value) return true
          return 'URL is required.'
        },
        value => {
          if (value?.length >= 5) return true
          return 'URL must be more than 5 characters.'
        },
      ],

      pageAltTextRules: [
        value => {
          if (value) return true
          return 'Alt text is required.'
        },
        value => {
          if (value?.length <= 1000) return true
          return 'Alt text must be less than 1000 characters.'
        },
        value => {
          if (value?.length >= 10) return true
          return 'Alt text must be more than 10 characters.'
        },
      ],

      // ---------

      viewPrintExisting: false,
      tab: null,
      headers: [
        { title: 'Title', align: 'start', key: 'title' },
        { title: 'Description', align: 'start', key: 'description' },
        { title: 'Copies Printed', align: 'end', key: 'countPrinted' },
        { title: 'Date Created', align: 'end', key: 'dateCreated' },
        { title: 'Creator', align: 'start', key: 'publisher' },
        { text: "", key: "controls", sortable: false },
      ],
      existingBooks: [],
      existingNewspapers: [],
      existingCards: [],
    }
  },
  mounted() {
    let self = this;
    window.addEventListener('message', this.onMessage);
    window.addEventListener('keyup', function (e) {
      if (e.key == "Escape") {
        self.fireEvent('closeAll')
      }
    });
  },
  destroyed() {
    window.removeEventListener('message')
    window.removeEventListener('keyup')
  },
  methods: {
    onMessage(event) {
      if (event.data.type === 'view') {
        this.config = event.data.config;
        this.locationId = event.data.locationId;
        if (event.data.screen === 'create') {
          this.viewCreate = true;
          this.viewCreateTypeAndArrangement = true;
        }else if (event.data.screen === 'printExisting') {
          this.viewPrintExisting = true;

          // Replace the stores of existing printables (by type)
          this.existingBooks = [];
          this.existingNewspapers = [];
          this.existingCards = [];
          for (let existingPrintable of event.data.existingPrintables) {

            // Convert the date
            var utcMilliseconds = existingPrintable.dateCreated;
            var d = new Date(0); // The 0 there is the key, which sets the date to the epoch
            d.setUTCMilliseconds(utcMilliseconds);
            existingPrintable.dateCreated = d;

            if (existingPrintable.type == 'book') {
              this.existingBooks.push(existingPrintable);
            }else if (existingPrintable.type == 'newspaper') {
              this.existingNewspapers.push(existingPrintable);
            }else if (existingPrintable.type == 'card') {
              this.existingCards.push(existingPrintable);
            }
          }
        }
      }
      if (event.data.type === 'close') {
        this.viewCreate = false;
        this.viewCreateTypeAndArrangement = false;
        this.viewCreateDetailsAndPages = false;
        this.viewPrintExisting = false;
      }

    },
    fireEvent(eve, opts = {}) {
      fetch(`https://${GetParentResourceName()}/` + eve, {
        method: 'POST',
        body: JSON.stringify(opts)
      })
    },
    async submitTypeAndArrangement(submitEventPromise) {
      const {valid, errors} = await submitEventPromise
      if (!valid) {
        return;
      }
      this.arrangementSelected();
    },
    arrangementSelected(){
      this.viewCreateTypeAndArrangement = false;
      this.viewCreateDetailsAndPages = true;
    },
    async addPage(submitEventPromise) {
      const {valid, errors} = await submitEventPromise
      if (!valid) {
        return;
      }
      this.dialogAddPage = false;
      this.submitNewPage();
      this.$refs.formCreateAddPage.reset();
    },
    submitNewPage() {

      if(this.pages.length >= this.maxNumPages){
        return;
      }

      let newPageNumber = this.pages.length + 1;
      this.pages.push(new Page(this.formAddPage.url, this.formAddPage.alt, newPageNumber));
    },
    async publish(submitEventPromise) {
      const {valid, errors} = await submitEventPromise
      if (!valid) {
        return;
      }

      if(this.pages.length < 1 || this.pages.length > this.maxNumPages){
        return;
      }

      this.fireEvent("publish", {type: this.createType, title: this.printableTitle, description: this.printableDescription, arrangement: this.createArrangement, pages: this.pages, locationId: this.locationId})

      // Reset the form models
      this.pages = [];
      this.printableTitle = "";
      this.printableDescription = "";

      // Hide everything
      this.viewCreate = false;
      this.viewCreateTypeAndArrangement = false;
      this.viewCreateDetailsAndPages = false;

      // Reset the form
      this.$refs.formCreate.reset();
    },
    printExisting(item) {
      this.fireEvent("print", { printableId: item.id, locationId: this.locationId })
    },
    format, // for 'timeago.js'
  },
  watch: {
    createType: function(val, oldVal) {
      if (val=='book') {
        this.maxNumPages = 20;
      }else if(val=='newspaper') {
        this.maxNumPages = 12;
      }else{
        this.maxNumPages = 1;
        this.createArrangement = 'VerticalInfinite';
      }
    }
  }
};

</script>

<template>
  <header>
  </header>

  <main>

    <!-- CREATE NEW -->

    <div class="wrapper ma-5" v-if="viewCreate">

      <div class="printing-box">

        <div class="float-right mr-7 mt-2">
          <v-btn variant="text" @click="fireEvent('closeAll')">x</v-btn>
        </div>

        <div class="printing-create">

          <v-container class="ma-5 w-auto pl-10 pr-11 py-3">
            <v-row>
              <v-col align-self="center">
                <div class="mx-5">
                  <h1 class="font-rdr text-center ml-5 mr-5">Printing Press</h1>
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <hr />
              </v-col>
            </v-row>
            <v-row>
              <v-col>

                <!-- CREATE NEW: Type & Arrangement -->

                <div v-if="viewCreateTypeAndArrangement">

                  <v-form ref="formTypeAndArrangement" validate-on="submit" @submit.prevent="submitTypeAndArrangement">

                    <div class="mb-4">
                      <span class="text-h6">Type</span>
                    </div>
                    <v-radio-group v-model="createType" :rules="createTypeRules" inline>
                      <v-radio value="book" class="mr-4">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>Book</strong>
                            </div>
                            <div class="type-item-thumbnail-container">
                              <img class="type-item-thumbnail" src="./assets/book.png" />
                            </div>
                            <div>
                              <span class="type-max-pages-text note-text">Max Pages: {{ this.config.PrintingRequirements.book.MaxPages }}</span>
                            </div>
                          </div>
                        </template>
                      </v-radio>
                      <v-radio value="newspaper" class="mr-4">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>Newspaper</strong>
                            </div>
                            <div class="type-item-thumbnail-container">
                              <img class="type-item-thumbnail" src="./assets/newspaper.png" />
                            </div>
                            <div>
                              <span class="type-max-pages-text note-text">Max Pages: {{ this.config.PrintingRequirements.newspaper.MaxPages }}</span>
                            </div>
                          </div>
                        </template>
                      </v-radio>
                      <v-radio value="card" class="mr-4">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>Card</strong>
                            </div>
                            <div class="type-item-thumbnail-container">
                              <img class="type-item-thumbnail" src="./assets/card.png" />
                            </div>
                            <div>
                              <span class="type-max-pages-text note-text">Max Pages: {{ this.config.PrintingRequirements.card.MaxPages }}</span>
                            </div>
                          </div>
                        </template>
                      </v-radio>
                    </v-radio-group>

                    <v-divider class="mb-5"></v-divider>

                    <div class="mb-4">
                      <span class="text-h6">Page Layout Arrangement</span>
                    </div>
                    <v-radio-group v-model="createArrangement" :rules="createArrangementRules">
                      <v-radio value="VerticalInfinite" class="mb-2">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>Infinite Vertical</strong>
                            </div>
                            <div class="note-text">
                              All pages are shown at once, lined up from top to bottom. No page-turning.
                            </div>
                          </div>
                        </template>
                      </v-radio>
                      <v-radio value="HorizontalOnePage" class="mb-2" :disabled="createType == 'card'">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>One Page at a Time</strong>
                            </div>
                            <div class="note-text">
                              Readers see one page at a time, and flip to see the next page.
                            </div>
                          </div>
                        </template>
                      </v-radio>
                      <v-radio value="HorizontalTwoPage" class="mb-2" :disabled="createType == 'card'">
                        <template v-slot:label>
                          <div>
                            <div>
                              <strong>Two Pages at a Time</strong>
                            </div>
                            <div class="note-text">
                              Readers see two pages at a time (i.e. in pairs). They flip to see the next pair.
                            </div>
                          </div>
                        </template>
                      </v-radio>
                    </v-radio-group>

                    <v-btn variant="tonal" type="submit">
                      Confirm
                    </v-btn>

                  </v-form>

                </div>


                <!-- CREATE NEW: Details & Pages -->

                <div v-if="viewCreateDetailsAndPages">
                  <!-- <div v-if="createArrangement == 'VerticalInfinite'"> -->
                  <div>

                    <v-form ref="formCreate" validate-on="submit" @submit.prevent="publish">

                      <div class="mb-8">
                        <div class="text-h6">Create New Printable</div>
                        <div class="text-caption">Warning: Once you click "Publish", nothing here can ever be edited again.</div>
                      </div>

                      <v-text-field
                        v-model="printableTitle"
                        color="primary"
                        label="Title"
                        variant="underlined"
                        :rules="printableTitleRules"
                      ></v-text-field>

                      <v-text-field
                        v-model="printableDescription"
                        color="primary"
                        label="Description"
                        variant="underlined"
                        :rules="printableDescriptionRules"
                      ></v-text-field>

                      <div class="list-pages">
                        <v-list
                          lines="three"
                          item-props
                          max-height="400px"
                          min-height="200px"
                          :rules="pagesRules"
                        >
                          <v-list-item
                            v-for="page in pages"
                            :key="page.index"
                          >
                            <template v-slot:prepend>
                              <div class="d-flex flex-column mb-6">
                                <div class="text-h6 mb-1">Page {{ page.index }}</div>
                                <div class="list-pages-page-item-thumb-container">
                                  <img :src="page.url" class="list-pages-page-item-thumb"/>
                                </div>
                              </div>
                            </template>
                          </v-list-item>
                        </v-list>

                        <div v-if="this.pages.length < this.maxNumPages">
                          <v-btn
                            prepend-icon="mdi-plus"
                            text="Add Page"
                            variant="outlined"
                            @click="this.dialogAddPage = true"
                          ></v-btn>
                        </div>
                      
                      </div>

                      <div class="float-right mt-2">
                        <v-btn
                          color="surface-variant"
                          text="Publish"
                          variant="flat"
                          type="submit"
                        ></v-btn>
                      </div>

                    </v-form>

                    <v-dialog
                      width="auto"
                      scrollable
                      persistent
                      @keydown.esc="this.dialogAddPage = false"
                      v-model="dialogAddPage"
                    >

                      <v-form ref="formCreateAddPage" validate-on="submit" @submit.prevent="addPage">
                        <v-card
                          prepend-icon="mdi-plus"
                          title="Add Page"
                        >
                          <v-divider class="mt-1 mb-1"></v-divider>

                          <v-card-text class="px-4" style="width:400px;">
                            
                              <v-text-field label="Image URL" v-model="formAddPage.url" :rules="pageUrlRules"></v-text-field>
                              <v-text-field label="Alt Text" v-model="formAddPage.alt" :rules="pageAltTextRules"></v-text-field>

                          </v-card-text>

                          <v-divider class="mt-1"></v-divider>

                          <v-card-actions class="ma-1">
                            <v-btn
                              text="Close"
                              @click="this.dialogAddPage = false"
                            ></v-btn>

                            <v-spacer></v-spacer>

                            <v-btn
                              color="surface-variant"
                              text="Add"
                              variant="flat"
                              type="submit"
                            ></v-btn>
                          </v-card-actions>
                        </v-card>
                      </v-form>

                    </v-dialog>

                    <div class="my-2">{{ this.pages.length }} pages total</div>

                    

                  </div>
                </div>

              </v-col>
            </v-row>
          </v-container>

        </div>
      </div>
    </div>







    <!-- PRINT EXISTING -->
    <div class="wrapper ma-5" v-if="viewPrintExisting">

      <div class="printing-box">

        <div class="float-right mr-7 mt-2">
          <v-btn variant="text" @click="fireEvent('closeAll')">x</v-btn>
        </div>

        <div class="printing-printExisting">

          <v-container class="ma-5 w-auto pl-10 pr-11 py-3">
            <v-row>
              <v-col align-self="center">
                <div class="mx-5">
                  <h1 class="font-rdr text-center ml-5 mr-5">Printing Press</h1>
                </div>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <hr />
              </v-col>
            </v-row>
            <v-row>
              <v-col
                max-height="400px"
                min-height="200px"
              >

                <div>
                  <div class="mb-8">
                    <div class="text-h6">Print Existing Printable</div>
                    <div class="text-caption">Select the existing printable that you want to print. You must have the needed supplies already in your pocket.</div>
                  </div>
                </div>

                <div>
                  <v-tabs
                    v-model="tab"
                    bg-color="deep-purple-darken-4"
                    align-tabs="center"
                  >
                    <v-tab value="books">Books</v-tab>
                    <v-tab value="newspapers">Newspapers</v-tab>
                    <v-tab value="cards">Cards</v-tab>
                  </v-tabs>

                  <v-tabs-window v-model="tab">
                    <v-tabs-window-item value="books">
                      <div v-if="this.config" class="mt-3 mb-2 recipe-text-container text-center">
                        <span class="recipe-text">{{ this.config.PrintingRequirements.book.RecipeText }}</span>
                      </div>
                      <v-data-table 
                        :items="existingBooks" 
                        :headers="headers"
                        item-key="id"
                        :sort-by="[{ key: 'title', order: 'asc' }]"
                        class="print-data-table"
                      >
                        <template v-slot:item.controls="props">
                          <v-btn class="mx-2" fab dark small color="grey-darken-4" @click="printExisting(props.item)">
                            <v-icon dark>mdi-cube-send</v-icon>
                          </v-btn>
                        </template>
                        <template v-slot:item.dateCreated="{ item }">
                          <span>{{ format(item.dateCreated, 'en_US') }}</span>
                        </template>
                      </v-data-table>
                    </v-tabs-window-item>
                    <v-tabs-window-item value="newspapers">
                      <div v-if="this.config" class="mt-3 mb-2 recipe-text-container text-center">
                        <span class="recipe-text">{{ this.config.PrintingRequirements.newspaper.RecipeText }}</span>
                      </div>
                      <v-data-table 
                        :items="existingNewspapers" 
                        :headers="headers"
                        item-key="id"
                        :sort-by="[{ key: 'title', order: 'asc' }]"
                        class="print-data-table"
                      >
                        <template v-slot:item.controls="props">
                          <v-btn class="mx-2" fab dark small color="grey-darken-4" @click="printExisting(props.item)">
                            <v-icon dark>mdi-cube-send</v-icon>
                          </v-btn>
                        </template>
                        <template v-slot:item.dateCreated="{ item }">
                          <span>{{ format(item.dateCreated, 'en_US') }}</span>
                        </template>
                      </v-data-table>
                    </v-tabs-window-item>
                    <v-tabs-window-item value="cards">
                      <div v-if="this.config" class="mt-3 mb-2 recipe-text-container text-center">
                        <span class="recipe-text">{{ this.config.PrintingRequirements.card.RecipeText }}</span>
                      </div>
                      <v-data-table 
                        :items="existingCards" 
                        :headers="headers"
                        item-key="id"
                        :sort-by="[{ key: 'title', order: 'asc' }]"
                        class="print-data-table"
                      >
                        <template v-slot:item.controls="props">
                          <v-btn class="mx-2" fab dark small color="grey-darken-4" @click="printExisting(props.item)">
                            <v-icon dark>mdi-cube-send</v-icon>
                          </v-btn>
                        </template>
                        <template v-slot:item.dateCreated="{ item }">
                          <span>{{ format(item.dateCreated, 'en_US') }}</span>
                        </template>
                      </v-data-table>
                    </v-tabs-window-item>
                  </v-tabs-window>
                </div>

              </v-col>
            </v-row>
          </v-container>

        </div>
      </div>
    </div>

  </main>
</template>

<style scoped>

</style>
