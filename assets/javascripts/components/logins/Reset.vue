<template>
  <div class="hero is-fullheight is-dark">
      <section>
        <div class="hero-body">
          <div id="new-complaint-form" class="container">
            <div id="stand-up" class="columns is-centered is-6">
              <h1 class="has-text-white title is-1">Reset Your Password</h1>
            </div>
            <div class="columns is-centered">
              <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                <div class="notification is-danger" v-if="invalid">
                  Passwords do not match.
                </div>
                <form ref="resetForm" :action="action" method="POST">
                  <input type="hidden" name="authenticity_token" v-model="csrf" />

                  <div class="field">
                    <label for="password" class="label has-text-white">New Password</label>
                    <div class="control has-icons-left">
                      <input type="password" name="password" placeholder="Enter your password." v-model="password" class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <label for="confirm" class="label has-text-white">Confirm</label>
                    <div class="control has-icons-left">
                      <input type="password" name="confirm" placeholder="Confirm your password." v-model="confirm" class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <button class="button is-success" @click.stop.prevent="validateMatch">
                      Change Password
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
</template>

<script>
  export default {
    props: ['reset-token'],

    data() {
      return {
        csrf: document.querySelector('meta[name=_csrf]').content,
        action: `/logins/reset/${this.resetToken}`,
        password: '',
        confirm: '',
        invalid: false,
      };
    },

    methods: {
      validateMatch() {
        if (this.password && this.confirm && this.password === this.confirm) {
          this.$refs.resetForm.submit();
        } else {
          this.invalid = true;
        }
      }
    }
  }
</script>