function checkLogin(){

	var userId=document.getElementById("userId").value;
	var password=document.getElementById("password").value;
	
	if(userId==""){
		document.getElementById("content").innerHTML="请输入用户名";
			return false;
	}
	
	if(password==""){
		document.getElementById("content").innerHTML="请输入密码";
		return false;
	}
	return true;
}
