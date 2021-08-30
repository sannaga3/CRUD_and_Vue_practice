import Vue from 'vue/dist/vue.esm.js'
import TaskList from '../task.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#app',
    components: { 'task-component': TaskList }
  })
})