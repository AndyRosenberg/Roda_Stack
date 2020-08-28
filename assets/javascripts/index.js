import Turbolinks from "turbolinks"
import '../stylesheets/main.scss';
import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm.js';
import './events/flash-delete-button.js';
import NewUserForm from './components/users/NewUserForm.vue';
import EditUserForm from './components/users/EditUserForm.vue';
import SignIn from './components/logins/SignIn.vue';
import ForgotPW from './components/logins/Forgot.vue';
import ResetPW from './components/logins/Reset.vue';

Turbolinks.start()
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: "#app",
    components: {
      'new-user-form': NewUserForm,
      'edit-user-form': EditUserForm,
      'sign-in': SignIn,
      'forgot-password': ForgotPW,
      'reset-password': ResetPW,
    }
  });
});
