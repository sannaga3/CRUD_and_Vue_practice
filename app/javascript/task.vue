<template>
  <div>
    <form @submit.prevent="addTask">
      <div class="d-flex flex-row">
        <input placeholder="create task" v-model="title"></input>
        <button type="submit" class="btn btn-info">送信</button>
        <div v-if="createError != ''" class="mx-3 text-center" style= "color: red; font-size: 1.5rem;">{{ createError }}</div>
      </div>
    </form>
    <div>
      <div class="d-flex flex-row mt-2">
        <div class="mx-3" style="min-width: 100px;">Title</div>
        <div class="mx-3 text-center" style="min-width: 160px;">Update</div>
      </div>
    </div>
    <div v-for="(task, index) in tasks" :key="task.id">
      <div class="d-flex flex-row my-1">
        <div class="mx-3 pt-2" style="min-width: 100px;">{{ task.title }}</div>
        <form @submit.prevent="updateTask(task.id, newTitle)">
          <input placeholder="update task" v-on:input="newTitle = $event.target.value" >
          <button type="submit" class="btn btn-info" style="margin-left: 20px;">更新</button>
        </form>
        <div class="mx-1" style="width: 228px; text-align: left;"><button style="margin-left: 20px;" @click="removeTask(task.id)" class="btn btn-danger">削除</button></div>
        <div v-if="index == errorId" class="mx-3 text-center" style="color: red; font-size: 1.5rem;">{{ updateError }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
const client = axios.create({
  baseURL: `http://localhost:3000`,
  headers: {
    'Accept': 'application/vnd.github.v3+json',
    'Content-Type':'application/json',
  }
})
client.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
}
export default {
  data: function () {
    return {
      tasks: [],
      title: "",
      newTitle: "",
      createError: "",
      updateError: "",
      errorId: ""
    }
  },
  mounted() {
    this.getTasks()
  },
  methods: {
    getTasks() {
      client.get('/tasks.json')
        .then((res) => {
          for(let i = 0; i < res.data.length; i++) {
            this.tasks.push({id: res.data[i].id, title: res.data[i].title });
          }
          this.tasks.sort(function( a,b ){
            if( a.id > b.id ) return -1;
            if( a.id < b.id ) return 1;
            return 0;
          })
          this.createError = ""
          this.updateError = ""
        })
    },
    addTask() {
      client.post('/tasks.json', { task: { title: this.title }})
        .then((res) => {
          this.tasks.unshift(res.data)
          this.title = ''
        })
        .catch(error => {
          if ( error.response.status == 422 )
            this.createError = "titleが未入力です"
            this.updateError = ""
        })
    },
    updateTask(id, title) {
      client.patch('/tasks/' + id + '.json', { title: title })
        .then((res) => {
          this.tasks = []
          this.newTitle = ""
          this.getTasks()
        })
        .catch(error => {
          this.errorId = error.response.request.responseURL.match( /http\:\/\/localhost\:3000\/tasks\/(\d+)\.json/)
          for(let i = 0; i < this.tasks.length; i++) {
            if ( this.tasks[i].id == this.errorId[1]){
              this.errorId = i
              break
            }
          }
          if ( error.response.status == 422 ) {
            this.updateError = "titleが未入力です"
            this.createError = ""
          }
        })
    },
    removeTask(id) {
      client.delete('/tasks/' + id + '.json')
        .then((res) => {
          this.tasks = []
          this.getTasks()
        })
    }
  }
}
</script>