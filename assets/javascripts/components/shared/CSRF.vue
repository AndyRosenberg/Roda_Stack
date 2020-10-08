<template>
  <input type="hidden" name="_csrf" v-model="csrf" />
</template>

<script>
  export default {
    data() {
      return {
        csrf: document.querySelector('meta[name=_csrf]').content,
      };
    }
  }
</script>