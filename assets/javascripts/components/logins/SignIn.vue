<template>
  <div class="hero is-fullheight is-dark">
      <section>
        <div class="hero-body">
          <div id="new-complaint-form" class="container">
            <div id="stand-up" class="columns is-centered is-6">
              <h1 class="has-text-white title is-1">Log In</h1>
            </div>
            <div class="columns is-centered">
              <div class="column is-5-tablet is-4-desktop is-3-widescreen">
                <form action="/logins/authenticate" method="POST">
                  <CSRF />
                  <div class="field">
                    <label for="email" class="label has-text-white">Username or Email</label>
                    <div class="control has-icons-left">
                      <input type="text" name="email" placeholder="Enter your username or email." class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <label for="password" class="label has-text-white">Password</label>
                    <div class="control has-icons-left">
                      <input type="password" name="password" placeholder="Enter your password." class="input" required>
                    </div>
                  </div>

                  <div class="field">
                    <button class="button is-success">
                      Sign In
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
  import CSRF from '../shared/CSRF.vue';
  export default {
    components: {
      CSRF
    }
  }
</script>