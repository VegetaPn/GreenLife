window.onload = init;

function init(){
	var display = false;
	var commentLink = document.getElementById("commentLink");
	var blackDiv = document.getElementById("blackDiv");
	var commentPost = document.getElementById("commentPost");
	
	commentLink.addEventListener('click',
	function(){
		if(display==false){
			blackDiv.style.display="inline";
			commentPost.style.display="inline";
			display = true;
		}
	},false);


	blackDiv.addEventListener('click',
	function(){
		if(display==true){
			blackDiv.style.display="none";
			commentPost.style.display="none";
			display = false;
		}
	},false);

}

