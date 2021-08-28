import Vue from 'vue/dist/vue.esm.js'
import Memo from '../memo.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#memo',
    components: { 'memo-component': Memo }
  })
})