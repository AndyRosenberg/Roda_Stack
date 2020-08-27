<template>
  <div class="hero is-fullheight is-dark">
      <section>
        <div class="hero-body">
          <div id="new-complaint-form" class="container">
            <div id="stand-up" class="columns is-centered is-6">
              <h1 class="has-text-white title is-1">Edit your account</h1>
            </div>
            <div class="columns is-centered">
              <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                <form :action="action" method="POST">
                  <input type="hidden" name="authenticity_token" v-model="csrf" />
                  <input type="hidden" name="_method" value="PUT" />

                  <div class="field">
                    <label for="email" class="label has-text-white">Email</label>
                    <div class="control has-icons-left">
                      <input type="email" name="email" v-model="email" class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <label for="username" class="label has-text-white">Username</label>
                    <div class="control has-icons-left">
                      <input type="text" name="name" v-model="name" class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <label for="password" class="label has-text-white">Password</label>
                    <div class="control has-icons-left">
                      <input type="password" name="password" v-model="password" class="input">
                    </div>
                  </div>
                  
      
                  <div class="field">
                    <button class="button is-success">
                      Update
                    </button>
                    <button class="button is-danger" @click.stop.prevent="promptDelete">
                      Delete my account
                    </button>
                  </div>
                </form>

                <div class="mt-2">
                  <form :action="action" method="POST" ref="deleteForm" v-if="showDelete">
                    <input type="hidden" name="authenticity_token" v-model="csrf" />
                    <input type="hidden" name="_method" value="DELETE" />
                    <div class="control has-icons-left mb-1">
                      <input type="text" name="confirm" class="input" v-model="deleteName" placeholder="type your username to confirm">
                    </div>

                    <div class="field">
                      <button class="button is-black">
                        Cormfirm
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
</template>

<script>
  export default {
    props: ['current-user'],

    data() {
      return {
        csrf: document.querySelector('meta[name=_csrf]').content,
        action: '',
        user: {},
        name: '',
        email: '',
        password: '',
        showDelete: false,
        deleteName: '',
      };
    },

    created() {
      this.user = JSON.parse(this.currentUser);
      this.action = `/users/${this.user.id}`;
      this.name = this.user.name;
      this.email = this.user.email;
    },

    methods: {
      promptDelete() {
        this.showDelete = !this.showDelete;
      },
    }
  }
</script>