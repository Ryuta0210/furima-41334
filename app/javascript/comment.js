const comment = () => {
  const commentForm = document.getElementById("comment_form");
  if (!commentForm) return;

  commentForm.addEventListener("submit", (e) => {
    e.preventDefault();
    const formData = new FormData(commentForm);
    const XHR = new XMLHttpRequest();
    const itemId = commentForm.dataset.itemId;
    XHR.open("POST", `/items/${itemId}/comments`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const comments = XHR.response.comments;
      updateCommentsDisplay(comments, itemId);
      commentForm.reset();
    };
  });

  const updateCommentsDisplay = (comments, itemId) => {
    const commentsContents = document.querySelector(".comment_contents");
    const currentUserId = document.getElementById("comments_index").dataset.currentUserId;
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
                <a href="#" class="comment_edit" data-comment-id="${comment.id}" data-comment-content="${comment.content}">編集</a>
                <a href="/items/${comment.item_id}/comments/${comment.id}" class="comment_delete" data-comment-id="${comment.id}" data-item-id="${itemId}">削除</a>` : ''}
              </div>
            </div>
          </div>`;
      commentsContents.insertAdjacentHTML("beforeend", commentHtml);
    });

    addEditEventListeners();
    addDeleteEventListeners();
  };

  const addDeleteEventListeners = () => {
    const deleteLinks = document.querySelectorAll(".comment_delete");
    deleteLinks.forEach(link => {
      link.addEventListener("click", (e) => {
        e.preventDefault();
        const commentId = link.dataset.commentId;
        const itemId = link.dataset.itemId;
        const XHR = new XMLHttpRequest();
        XHR.open("DELETE", `/items/${itemId}/comments/${commentId}`, true);
        XHR.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
        XHR.responseType = "json";
        XHR.send();

        XHR.onload = () => {
          const comments = XHR.response.comments;
          updateCommentsDisplay(comments, itemId);
        };
      });
    });
  };

  // 編集イベントリスナーの追加
  const addEditEventListeners = () => {
    const editLinks = document.querySelectorAll(".comment_edit");
    editLinks.forEach(link => {
      link.addEventListener("click", (e) => {
        e.preventDefault();
        const commentId = link.dataset.commentId;
        const commentContent = link.dataset.commentContent;
        const commentElement = document.querySelector(`.comment[data-comment-id="${commentId}"]`);
        const editFormHtml = `
          <div class="edit_comment_form">
            <textarea class="edit_comment_input">${commentContent}</textarea>
            <div class="save_edit_comment">
              <button type="button" class="save_comment">保存</button>
              <button type="button" class="cancel_edit">元に戻す</button>
          </div>
          </div>
        `;
        commentElement.innerHTML = editFormHtml;

        // 保存ボタンのイベントリスナー
        const saveButton = commentElement.querySelector(".save_comment");
        const cancelButton = commentElement.querySelector(".cancel_edit");

        saveButton.addEventListener("click", () => {
          const updatedContent = commentElement.querySelector(".edit_comment_input").value;
          updateComment(commentId, updatedContent);
        });

        // 元に戻すボタンのイベントリスナー
        cancelButton.addEventListener("click", () => {
          revertToOriginalComment(commentElement, commentContent);
        });
      });
    });
  };

  // コメントの更新
  const updateComment = (commentId, updatedContent) => {
    const XHR = new XMLHttpRequest();
    const itemId = commentForm.dataset.itemId;
    XHR.open("PATCH", `/items/${itemId}/comments/${commentId}`, true);
    XHR.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    XHR.responseType = "json";
    XHR.send(JSON.stringify({ content: updatedContent }));

    XHR.onload = () => {
      const comments = XHR.response.comments;
      updateCommentsDisplay(comments);
    };
  };

  // 元に戻す機能
  const revertToOriginalComment = (commentElement, originalContent) => {
    const originalHtml = `
      <div class="comment_content">${originalContent}</div>
      <div class="comment_right">
        <div class="comment_user">投稿者： ${commentElement.querySelector(".comment_user").innerText}</div>
        <div class="comment_edit_delete">
          <a href="#" class="comment_edit" data-comment-id="${commentElement.dataset.commentId}" data-comment-content="${originalContent}">編集</a>
          <a href="#" class="comment_delete" data-comment-id="${commentElement.dataset.commentId}">削除</a>
        </div>
      </div>
    `;
    commentElement.innerHTML = originalHtml;
    addEditEventListeners();
    addDeleteEventListeners();
  };

  addDeleteEventListeners(); // 最初に削除イベントリスナーを追加
  addEditEventListeners()
};

window.addEventListener("turbo:load", comment);