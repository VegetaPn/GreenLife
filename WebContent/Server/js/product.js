function showInfo(value) {
	alert(value);
	var xmlhttp = getXMLHttpRequest();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var con=document.getElementById("myDiv");
		    con.setAttribute("z-index","-1");
		    con.innerHTML=xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "showInfo.jsp?id=" + value, false);
	xmlhttp.send();
	
}

function getXMLHttpRequest() {

	var xhr;
	if (window.ActiveXObject) {
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xhr = new XMLHttpRequest();
	} else {
		xhr = null;
	}
	return xhr;
}
