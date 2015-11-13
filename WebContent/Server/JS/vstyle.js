/**
 * 添加投票&显示结果的js
 */
function addInput(line)
{
    var mf = document.getElementById("suspendInput");
    mf.innerHTML = "";
    
    for (var i=0; i<line; i++) {
    	var html = "<p align='center'>候选人"+(i+1)+": <input placeholder='请输入候选人姓名' name='cm"+(i+1)+"'></p>";
        mf.innerHTML += html;
    }  
}

function clearInput() {
	var mf = document.getElementById("suspendInput");
	mf.innerHTML = "";
}

function checkValue(sus) {
	var selected = document.getElementById("selected");
	
	for (var i=0; i<selected.length; i++) {
		selected.options[i].disabled=true;
	}
	
	for (var i=0; i<sus; i++) {
		selected.options[i].disabled=false;
	}
	
	if (sus < selected.selectedIndex+1) {
		selected.selectedIndex = sus - 1;
	}
}

function validate_required(field,alerttxt)
{
	with (field)
	{
		if (value==null||value=="")
		  {alert(alerttxt);return false}
		else {return true}
	}
}

function validate_form(thisform)
{
	with (thisform)
    {
		if (validate_required(email,"Email must be filled out!")==false)
		{email.focus();return false}
    }
}

function validate_jobname(unitform)
{
	alert(unitform.jobname.value);
	if (unitform.jobname.value=='') {
		alert('职务名称不能为空！');
		form.jobname.focus();
		return false;
	}
	return true;
}