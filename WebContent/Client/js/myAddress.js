window.onload = init;

window.onresize = resize;

function init(){
    var dCusInfors = document.getElementsByClassName("dCusInfor");
	for(var i=0;i<dCusInfors.length;i++){
	    dCusInfors[i].onclick = displayMask;
	}
		
	document.getElementById("dMask").onclick = hiddMask;
	document.getElementById("setDefault").addEventListener('click',function(e){e.stopPropagation()},false);
	
}

function displayMask(){
   document.getElementById("dMask").style.display = "block";

   resize();
}

function hiddMask(){
   document.getElementById("dMask").style.display = "none";
}

function resize(){
   var screenHeight = window.screen.height;
   var maskHeight = document.getElementById("dMask").offsetHeight;
   var bodyHeight = document.body.clientHeight;
   
   var max = maskHeight;
   if(max<screenHeight)
      max = screenHeight;
   else if(max<bodyHeight)
      max = bodyHeight;
 
   document.getElementById("dMask").style.height = max+"px";
   
}