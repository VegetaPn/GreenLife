
function validate(){
	var consigne = document.getElementById("iConsignee").value;
	var phoneNo = document.getElementById("iPhnoe").value;
	var regione = document.getElementById("iRegione").value;
	var address = document.getElementById("iAddress").value;
	var reg = /^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$/;
	alert(phoneNo);
	
	if(consigne == ""){
		return false;
	}
	else if(phoneNo==""||!reg.test(phoneNo)){
		alert("手机号码填写不符合规范！");
		return false;
	}
	else if(regione == ""){
		return false;
	}
	else if(address == ""){
		return false;
	}
	
	alert("success");
	return true;
}