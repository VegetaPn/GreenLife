function validation(){
   var org = document.getElementById("organization").value;
   var num = document.getElementById("number").value;
   if(org == null||org == ""){
      alert("请填写单位信息");
   }
   if(num == null||num == ""){
      alert("请填写生成密码的个数");
      return;
   }
   
}


function check(){
alert("a");
}