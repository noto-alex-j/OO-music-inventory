// ----------------------- Add Song Form Modal
window.addEventListener("load", function(){

  var button = document.getElementById("addSongButton");

  button.addEventListener("click", function(){

  var addModal = document.getElementById("addSongForm");

  addModal.style.visibility = "visible";
  });
  
});

// ----------------------- Close Add Song Form Modal
window.addEventListener("load", function(){

  var button = document.getElementById("addClose");

  button.addEventListener("click", function(){

  var deleteModal = document.getElementById("addSongForm");

  deleteModal.style.visibility = "hidden";
  });
  
});


// ----------------------- Delete Song Form Modal
window.addEventListener("load", function(){

  var button = document.getElementById("deleteSongButton");

  button.addEventListener("click", function(){

  var deleteModal = document.getElementById("deleteSongForm");

  deleteModal.style.visibility = "visible";
  });
  
});

// ----------------------- Close Delete Song Form Modal
window.addEventListener("load", function(){

  var button = document.getElementById("deleteClose");

  button.addEventListener("click", function(){

  var deleteModal = document.getElementById("deleteSongForm");

  deleteModal.style.visibility = "hidden";
  });
  
});

//------------------------- Artist Tab JS

window.addEventListener("load", function(){

var albumstab = document.getElementById("artistTab__albums");
var trackstab = document.getElementById("artistTab__tracks");
var artiststab = document.getElementById("artistTab__artists");
var albumscontent = document.getElementById("topAlbums");
var trackscontent = document.getElementById("topTracks");
var artistscontent = document.getElementById("similarArtists");

albumstab.addEventListener("click", function(){
  albumstab.style.background = "grey";
  trackstab.style.background = "white";
  artiststab.style.background = "white";

  albumstab.style.color = "white";
  trackstab.style.color = "black";
  artiststab.style.color = "black";

  albumscontent.style.display = "flex";
  trackscontent.style.display = "none";
  artistscontent.style.display = "none";
});

trackstab.addEventListener("click", function(){
  albumstab.style.background = "white";
  trackstab.style.background = "grey";
  artiststab.style.background = "white";

  albumstab.style.color = "black";
  trackstab.style.color = "white";
  artiststab.style.color = "black";

  trackscontent.style.display = "flex";
  albumscontent.style.display = "none";
  artistscontent.style.display = "none";
});

artiststab.addEventListener("click", function(){
  albumstab.style.background = "white";
  trackstab.style.background = "white";
  artiststab.style.background = "grey";

  albumstab.style.color = "black";
  trackstab.style.color = "black";
  artiststab.style.color = "white";

  artistscontent.style.display = "flex";
  albumscontent.style.display = "none";
  trackscontent.style.display = "none";
});




})


