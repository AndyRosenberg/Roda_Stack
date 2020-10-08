<template>
  <article v-if="flash.message" id="flash" class="message is-info is-fullwidth" :class="{ 'is-hidden': hidden }">
    <div class="message-header">
      <p>{{ flash.message }}</p>
      <span id="flash-delete">
        <button class="delete" aria-label="delete" @click="hide"></button>
      </span>
    </div>
  </article>
</template>

<script>
  export default {
    props: ['content'],

    data() {
      return {
        hidden: false,
        flash: {},
      };
    },

    created() {
      this.flash = JSON.parse(this.content);
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