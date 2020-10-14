import Turbolinks from "turbolinks"
import '../stylesheets/main.scss';
import TurbolinksAdapter from 'vue-turbolinks';
import { createApp } from 'vue/dist/vue.esm-bundler.js';
import components from './components/components.js';

Turbolinks.start()

const startVue = () => {
  createApp(
    {components: components}
  ).use(TurbolinksAdapter).mount("#app");
}

document.addEventListener('turbolinks:load', () => {
  startVue();
});
