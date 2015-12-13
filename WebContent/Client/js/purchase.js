
function decrease(){
	var number = document.getElementById("iNumber").value;
	if(number>=1){
		number = parseInt(number) - 1;
		document.getElementById("iNumber").value = number;
		document.getElementById("sNumber").innerText = number;
		var price = document.getElementById("sProductPrice").innerText;
		document.getElementById("stPrice").innerText = parseInt(number)*parseFloat(price);
		document.getElementById("sTotalPrice").innerText = parseInt(number)*parseFloat(price);
	}
}

function increase(){
	var number = document.getElementById("iNumber").value;
	number = parseInt(number) + 1;
	if(number>reminder){
		alert("供货不足！");
		return;
	}
	document.getElementById("iNumber").value = number;
	document.getElementById("sNumber").innerText = number;
	var price = document.getElementById("sProductPrice").innerText;
	var total = (parseInt(number)*parseFloat(price)).toFixed(2);
	document.getElementById("stPrice").innerText = total;
	
	document.getElementById("sTotalPrice").innerText = total;
}

function calculate(){
	var number = document.getElementById("iNumber").value;
	var re = /^[1-9]+[0-9]*]*$/;
    if(!re.test(number)){
    	document.getElementById("iNumber").value = parseInt(number);
        alert("请输入整数");  
         return;  
    }
	document.getElementById("sNumber").innerText = number;
	var price = document.getElementById("sProductPrice").innerText;
	var total = (parseInt(number)*parseFloat(price)).toFixed(2);
	document.getElementById("stPrice").innerText = total;
	
	document.getElementById("sTotalPrice").innerText = total;	
}

function mousedown(){
	document.getElementById("iToAddress").src = "../images/rightArrowCircle2.png"
}

function mouseup(){
	document.getElementById("iToAddress").src = "../images/rightArrowCircle3.png"
}