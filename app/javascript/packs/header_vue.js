import Vue from 'vue/dist/vue.esm.js'
import Header from '../header.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#header',
    components: { 'navbar': Header }
  })
})