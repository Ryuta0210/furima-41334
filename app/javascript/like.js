document.addEventListener("turbo:load", () => {
  const likeButton = document.querySelector('.favorite-btn');

  if (likeButton) {
    likeButton.addEventListener('click', (event) => {
      event.preventDefault(); // デフォルトの動作を防ぐ

      fetch(likeButton.href, {
        method: 'POST',
        headers: {
          'Accept': 'application/json',
        },
      })
      .then(response => response.json())
      .then(data => {
        if (data.likes_count !== undefined) {
          document.querySelector('#likes-count').textContent = `お気に入り ${data.likes_count}`;
        }
      });
    });
  }
});