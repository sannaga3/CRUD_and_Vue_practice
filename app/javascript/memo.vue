<template>
  <tr>
    <td style="padding: 0 20px;">{{ content }}</td>
    <form action="/blogs/1" method="post"></form><input type="hidden" name="_method" value="patch"><input type="hidden" name="authenticity_token">
    <td><input value="" style="margin-right: 20px;" type="text" name="blog[content]" id="blog_content"></td>
    <td><input type="submit" name="commit" value="更新" class="btn btn-outline-secondary" style="margin-right: 10px;" data-disable-with="更新"></td>
    <td><a data-confirm="Are you sure?" class="btn btn-outline-info" rel="nofollow" data-method="delete" href="/blogs/1">削除</a></td>
  </tr>
</template>

<script>
export default {
  data: function () {
    return {
      content: ""
    }
  },
}
</script>