<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript">
$(function(){
	/*$.validator.setDefaults({
		submitHandler:function(){
			alert("sumit");
		}
	});*/
	//如果要添加带参数的验证使用以下方式
	$.validator.methods.nc = function(value,element,param){
		//如果返回true表示验证成功，返回false表示验证失败
		return param===value;
	};
	$.validator.addMethod("ncg",function(value){
		return value==="foobar";
	},"用户名必须为foobar");
	$.validator.addMethod("nameConflict",function(value) {
		var rel = true;
		
		//此时get方法是异步的，所以当rel返回的时候，get方法可能没有执行完毕
		//以下方法可以设置为同步请求
		$.ajaxSetup({async:false});
		$.get("v.do?username="+value,function(data){
			//如果在这个里面返回，仅仅只是闭包返回了，addMethod依然是false
			rel = data;
		});
		//设置完就还原
		$.ajaxSetup({async:true});
		//此时永远返回true
		return rel;
	},"用户名已经存在");
	$("#addForm").validate({
		//关闭输入字符的验证，因为在ajax中会多次提交
		onkeyup:false,
		rules:{
			username:{
				required:true,
				nameConflict:true
			},
			password:"required",
			conPwd:{
				equalTo:"#password"
			},
			email:"email"
		},
		messages:{
			username:{
				required:"用户名不能为空"
			},
			password:"用户密码不能为空",
			conPwd:"确认密码必须和密码一致",
			email:"邮件格式不正确"
		},
		submitHandler:function(){
		}
	});
})
</script>
</head>
<body>
<form action="register.do" method="post" id="addForm">
	Username:<input type="text" id="username" name="username"/><br/>
	Password:<input type="password" id="password" name="password"/><br/>
	ConfirmPwd:<input type="password" id="conPwd" name="conPwd"/><br/>
	Email:<input type="text" id="email" name="email"/><br/>
	<input type="submit"/>
</form>
</body>
</html>