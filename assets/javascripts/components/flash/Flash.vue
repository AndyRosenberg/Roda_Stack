<template>
  <article v-if="message" id="flash" class="message is-info is-fullwidth" :class="flashClass">
    <div class="message-header">
      <p>{{ message }}</p>
      <span id="flash-delete">
        <button class="delete" aria-label="delete" @click="hide"></button>
      </span>
    </div>
  </article>
</template>

<script>
  export default {
    props: ['message', 'klass'],

    computed: {
      flashClass() {
        let result = { 'is-hidden': this.hidden };
        result[`is-${this.klass}`] = true;
        return result;
      }
    },

    data() {
      return {
        hidden: false,
      };
    },

    methods: {
      hide() {
        this.hidden = true;
      }
    }
  }
</script>

<style scoped>
  #flash {
    margin: 0;
    position: fixed;
    width: 100%;
    bottom: 0;
    z-index: 2;
  }

  #flash.is-hidden {
    transition: all 2s ease-in;
  }
</style>