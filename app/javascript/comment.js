const comment = () => {
  const commentForm = document.getElementById("comment_form")
  commentForm.addEventListener("submit", (e)=>{
    console.log("OK")
    e.preventDefault()
    const formData = new FormData(commentForm)
    const XHR = XMLHttpRequest()
    XHR.open("POST", "/posts", true)
    XHR.responseType = "json"
    XHR.send(formData)
    XHR.onload = () => {
      const commentsIndex = document.getElementById("comments_index")
      const comments = XHR.response.post
      const html = `
        <div class="comments">
          <div class="comments_title"><p>コメント一覧</p></div>
          <div class="comment_contents">
          <% @comments.each do |comment|%>
          <div class="comment">
            <div class="comment_content"><%= comment.content %></div>
            <div class="comment_user">投稿者： <%= comment.user.nickname %></div>
          </div>
          <% end %>
        </div>
        </div>`
        commentsIndex.insertAdjacentHTML("afterend")
    }
  })
}
window.addEventListener("load", comment)