
function validate(){
	var consigne = document.getElementById("iConsignee").value;
	var phoneNo = document.getElementById("iPhnoe").value;
	var regione = document.getElementById("iRegione").value;
	var address = document.getElementById("iAddress").value;
	var reg = /^((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)$/;
	
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
	
	return true;
}