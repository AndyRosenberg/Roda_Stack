<template>
  <div class="hero is-fullheight is-dark">
      <section>
        <div class="hero-body">
          <div id="new-complaint-form" class="container">
            <div id="stand-up" class="columns is-centered is-6">
              <h1 class="has-text-white title is-1">Forgot Password</h1>
            </div>
            <div class="columns is-centered">
              <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                <form action="/logins/forgot" method="POST">
                  <input type="hidden" name="authenticity_token" v-model="csrf" />
                  <div class="field">
                    <label for="email" class="label has-text-white">Email</label>
                    <div class="control has-icons-left">
                      <input type="email" name="email" placeholder="Enter your username or email." class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <button class="button is-success">
                      Send Email
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
    data() {
      return {
        csrf: document.querySelector('meta[name=_csrf]').content,
      };
    },
  }
</script>