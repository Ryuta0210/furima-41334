function likes_count() {
  const likeButton = document.getElementById("like-button");
  const likesCount = document.getElementById("likes-count");

  let liked = false; 

  likeButton.addEventListener("click", (event) => {
    event.preventDefault();

    const XHR = new XMLHttpRequest();
    XHR.open("POST", likeButton.href, true);
    XHR.setRequestHeader("X-CSRF-Token", document.querySelector('meta[name="csrf-token"]').content);
    XHR.responseType = "json";
    XHR.send();

    XHR.onload = () => {
      const likesCounting = XHR.response.likes_count;

      if (liked) {
        likesCount.textContent = `${likesCounting} いいね`;
        likeButton.style.backgroundColor = "white";
      } else {
        likesCount.textContent = `${likesCounting} いいね`;
        likeButton.style.backgroundColor = "yellow";
      }

      liked = !liked;
    };
  });
}

window.addEventListener("turbo:load", likes_count);