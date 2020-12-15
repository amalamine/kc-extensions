function drop() {
  document.getElementById("kc-locale-dropdown").classList.toggle("show");
  document.getElementById("kcdrop").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(e) {
  if (!e.target.matches('kc-current-locale-link')) {
    var myDropdown = document.getElementById("kc-current-locale-link");
    if (myDropdown.classList.contains('show')) {
      myDropdown.classList.remove('show');
    }
  }
}