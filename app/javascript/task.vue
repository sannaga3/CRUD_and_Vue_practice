<template>
  <div>
    <div class="d-flex flex-row">
      <form @submit.prevent="addTask">
        <input placeholder="create task" v-model="title"></input>
        <button type="submit" class="btn btn-info">送信</button>
      </form>
    </div>
    <div>
      <div class="d-flex flex-row mt-2">
        <div class="mx-3" style="min-width: 100px;">Title</div>
        <div class="mx-1" style="width: 228px; text-align: center;">delete_button</div>
      </div>
    </div>
    <div v-for="(task, index) in tasks" :key="task.id">
      <div class="d-flex flex-row">
        <div class="mx-3 pt-2" style="min-width: 100px;">{{ task.title }}</div>
        <form @submit.prevent="updateTask(task.id, task.title)">
          <input placeholder="update task" :value="task.title"></input>
          <button type="submit" class="btn btn-info">更新</button>
        </form>
        <div class="mx-1" style="width: 228px; text-align: center;"><button style="margin-left: 30px;" @click="removeTask(task.id)" class="btn btn-danger">削除</button></div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
}
const client = axios.create({
  baseURL: `http://localhost:3000`,
  headers: {
    'Accept': 'application/vnd.github.v3+json',
    'Content-Type':'application/json',
  }
})
export default {
  data: function () {
    return {
      tasks: [],
      title: ""
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
          console.log(this.tasks[0].id)
          console.log(this.tasks[0].title)
        })
    },
    addTask() {
      client.post('/tasks.json', { task: { title: this.title }})
        .then((res) => {
          this.tasks.unshift(res.data)
          console.log(this.tasks)
          this.title = ''
        })
    },
    updateTask(id, title) {
      client.patch('/tasks/' + id,  { title: title })
        .then((res) => {
          console.log(res.data)
        })
    },
    removeTask(id) {
      client.delete('/tasks/' + id)
        .then((res) => {
          this.tasks = []
          this.getTasks()
        })
    }
  }
}
</script>