const comment = () => {
  const commentForm = document.getElementById("comment_form");
  if (!commentForm) return;

  commentForm.addEventListener("submit", (e)=>{
    e.preventDefault()
    const formData = new FormData(commentForm)
    const XHR = new XMLHttpRequest()
    const itemId = commentForm.dataset.itemId;
    XHR.open("POST", `/items/${itemId}/comments`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const comments = XHR.response.comments
      const commentsContents = document.querySelector(".comment_contents");
      const currentUserId = document.getElementById("comments_index").dataset.currentUserId;
      commentsContents.innerHTML = '';
      comments.forEach(comment => {
        const isCurrentUser = currentUserId && parseInt(currentUserId) === comment.user_id;
        const commentHtml = `
          <div class="comment">
            <div class="comment_content">${comment.content}</div>
            <div class="comment_right">
              <div class="comment_user">投稿者： ${comment.user.nickname}</div>
              <div class="comment_edit_delete">
                ${isCurrentUser ? `
                <a href="/items/${comment.item_id}/comments/${comment.id}/edit" class="comment_edit">編集</a>
                <a href="/items/${comment.item_id}/comments/${comment.id}" class="comment_delete" data-comment-id="${comment.id}" data-item-id="${itemId}">削除</a>` : ''}
              </div>
            </div>
          </div>`;
        commentsContents.insertAdjacentHTML("beforeend", commentHtml);
      })
    addDeleteEventListeners();
    commentForm.reset()
  }
})
const addDeleteEventListeners = () => {
  const deleteLinks = document.querySelectorAll(".comment_delete");
  deleteLinks.forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const commentId = link.dataset.commentId;
      const itemId = link.dataset.itemId;
      const XHR = new XMLHttpRequest();
      XHR.open("DELETE", `/items/${itemId}/comments/${commentId}`, true);
      XHR.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content)
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const commentsContents = document.querySelector(".comment_contents");
        const currentUserId = document.getElementById("comments_index").dataset.currentUserId;
        const comments = XHR.response.comments;
        commentsContents.innerHTML = '';
        comments.forEach(comment => {
          const isCurrentUser = currentUserId && parseInt(currentUserId) === comment.user_id;
          const commentHtml = `
            <div class="comment" data-comment-id="${comment.id}">
              <div class="comment_content">${comment.content}</div>
              <div class="comment_right">
                <div class="comment_user">投稿者： ${comment.user.nickname}</div>
                <div class="comment_edit_delete">
                  ${isCurrentUser ? `
                  <a href="/items/${comment.item_id}/comments/${comment.id}/edit" class="comment_edit">編集</a>
                  <a href="/items/${comment.item_id}/comments/${comment.id}" class="comment_delete" data-comment-id="${comment.id}" data-item-id="${itemId}">削除</a>` : ''}
                </div>
              </div>
            </div>`;
          commentsContents.insertAdjacentHTML("beforeend", commentHtml);
        });
        addDeleteEventListeners();
      };
    });
  });
  };
  addDeleteEventListeners();

  
};


window.addEventListener("turbo:load", comment);
