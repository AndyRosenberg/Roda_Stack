window.addEventListener('load', () => {
  let deleteBtn = document.getElementById('flash-delete');
  if (deleteBtn) {
    deleteBtn.addEventListener('click', (e) => {
      document.getElementById('flash').classList.add('is-hidden');
    });
  }
});

