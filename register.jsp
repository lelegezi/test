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
	$("#addForm").validate({
		rules:{
			username:"required",
			password:"required",
			conPwd:{
				equalTo:"#password"
			},
			email:"email"
		},
		messages:{
			username:"用户名不能为空",
			password:"用户密码不能为空",
			conPwd:"确认密码必须和密码一致",
			email:"邮件格式不正确"
		},
		submitHandler:function(){
			$.get("v.do?username="+$("#username").val(),function(data){
				if(!data) {
					$("#username").after("用户名已经存在");
				}
			});
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