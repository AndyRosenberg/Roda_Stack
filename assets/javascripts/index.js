import Turbolinks from "turbolinks"
import '../stylesheets/main.scss';
import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm.js';
import './events/flash-delete-button.js';
import components from './components/components.js';

Turbolinks.start()
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  new Vue({
    el: "#app",
    components: components
  });
});
