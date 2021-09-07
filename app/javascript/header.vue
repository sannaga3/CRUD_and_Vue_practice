<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="/users/new">sign_up</a></li>
        <li class="nav-item"><a class="nav-link" href="/sessions/new">login</a></li>
        <li class="nav-item"><a class="nav-link" href="/users/2">プロフィール</a></li>
        <li class="nav-item"><a class="nav-link" href="/memos">Memos</a></li>
        <li class="nav-item"><a class="nav-link" href="/tasks">Tasks</a></li>
        <li class="nav-item"><a class="nav-link" href="/sessions/2" data-method="delete">logout</a></li>
      </ul>
    </div>
  </nav>
</template>

<script>


export default {
  data: function () {
    return {
      userId: ""
    }
  },
  mounted() {
    this.getTasks()
  },
  methods: {
    getUserId() {
      a = window.sessionStorage.getItem(['email']);
      console.log(a);
    }
  }
}
</script>