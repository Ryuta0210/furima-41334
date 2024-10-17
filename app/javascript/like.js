function likes_count() {
  const likeButton = document.getElementById("like-button");

    likeButton.addEventListener("click", (event) => {
      event.preventDefault();

      const XHR = new XMLHttpRequest();
      XHR.open("POST", likeButton.href, true);
      XHR.setRequestHeader("X-CSRF-Token", document.querySelector('meta[name="csrf-token"]').content);
      XHR.responseType = "json";
      XHR.send();

      XHR.onload = ()=>{
        const likesCount = document.getElementById("likes-count")
        const likesCounting = XHR.response.likes_count
        likesCount.textContent = `${likesCounting} いいね`
      }
    });
}

window.addEventListener("turbo:load", likes_count);