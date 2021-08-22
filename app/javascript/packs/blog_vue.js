import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#form',
    data: {
      message: "Can you say hello?",
    },
    components: { App }
  })
})