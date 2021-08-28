<template>
  <div>
    <h1>Todoリスト</h1>
    <form @submit.prevent="addTodo()">
      <input placeholder="Please input content" v-model="blog.content"></input>
    </form>
    <div>
      <div v-for="( blog, index ) in blogs" :key="index">
        <div style="margin: 5px 0;">
          {{ content }}
          <button type="submit" style="margin-left: 30px;" @click="removeTodo(index)"></button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
const HTTP = axios.create({
  headers: {
    'Accept': 'application/json',
    'Content-Type':'application/json',
  },
})
const URL_DATA = 'http://localhost:5000/blogs'
export default {
  data () {
    return {
      content: "",
      contents: []
    }
  },
  methods: {
    getContents() {
      return HTTP.get(URL_DATA,
        {
          status: 'open',
        },
      )
      .then((res) => {
        this.contents = res.data
      })
    },
    onSubmit(){
      HTTP.post(URL_DATA,{
        content: this.content
      })
        .then((res) => {
          if (res.status === 200) {
            //登録完了
          } else {
            throw new Error('レスポンスエラー')
          }
          this.content="";
      })
    },
    deleteContent(index){
      HTTP.delete(URL_DATA + index)
      .then((res) => {
        if (res.status === 200) {
          //削除完了
        } else {
          throw new Error('レスポンスエラー')
        }
        this.getContents();
      })
    }
  }
}
</script>