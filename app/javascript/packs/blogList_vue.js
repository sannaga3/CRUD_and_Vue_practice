import Vue from 'vue/dist/vue.esm.js'
import BlogList from '../blogList.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#blog_wrapper',
    components: { 'blog-list': BlogList }
  })
})