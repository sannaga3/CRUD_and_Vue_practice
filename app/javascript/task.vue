<template>
  <div>
    <div class="d-flex flex-row">
      <form action="/tasks.json" accept-charset="UTF-8" data-remote="true" method="post">
        <input placeholder="create task" v-model="title" @submit="addTask"></input>
        <input @click.prevent="addTask" type="submit" class="btn btn-info"></input>
      </form>
    </div>
    <div>
      <div class="d-flex flex-row mt-2">
        <div class="mx-3" style="min-width: 100px;">Title</div>
        <div class="mx-1" style="width: 228px; text-align: center;">delete_button</div>
      </div>
    </div>
    <div v-for="(task, index) in tasks" :key="title.id">
      <div class="d-flex flex-row">
        <div class="mx-3 pt-2" style="min-width: 100px;">{{ task.title }}</div>
        <form>
          <input placeholder="update task" :value="task.title"></input>
          <button @click.prevent="updateTask(task.id, task.title)" class="btn btn-info">更新</button>
        </form>
        <div class="mx-1" style="width: 228px; text-align: center;"><button style="margin-left: 30px;" @click="removeTask(task.id)" class="btn btn-danger">削除</button></div>
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
export default {
  data: function () {
    return {
      title: "",
      task: "",
      tasks: []
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
      console.log(this.title)
      client.post('/tasks', { task: { title: this.title }})
        .then((res) => {
          this.tasks.unshift(res.data)
          console.log(this.tasks)
          this.title = ''
        })
    },
    updateTask(id, title) {
      client.put(('/tasks/' + id ), { title: title } )
        .then((res) => {
          console.log(res.data)
        })
    },
    removeTask(id) {
    client.delete(`/tasks/${id}`)
      .then((res) => {
        this.getTasks()
      })
    }
  }
}
</script>