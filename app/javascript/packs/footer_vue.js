import Vue from 'vue/dist/vue.esm.js'
import Footer from '../footer.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#footer',
    components: { 'footer-component': Footer }
  })
})