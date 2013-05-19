<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="zh-en">
<head>
<meta charset="utf-8">
<title>用户登陆</title>

<script src="/voc_info/res/js/jquery-1.8.2.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/jquery-ui-1.9.2.custom.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/validation-login.js" type="text/javascript"></script>

<link href="/voc_info/res/css/jquery-ui-1.10.1.custom.min.css"
	rel="stylesheet">
<link href="/voc_info/res/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
.error {
	color: red;
}

td {
	padding: 0.3em 40px;
}
</style>

<script type="text/javascript">

	function login(){
		if($("#form_login").valid()){
			$.ajax({
				url:"/voc_info/login",
				type:"post",
				dataType:"json",
				data:{
					username	:	$("#username").val(),
					password	:	$("#password").val()
				},
				success:function(data,textState){
					if(!data.success){//错误
						$("#error_field").html("");
						$("#error_field").append("<label class='error-login' style='color:red'>用户名或密码错误</label>");
					}else{//正确
						window.location = "/voc_info/showInfo?userId="+data.userId;
					}
				}
			});
		}
	}

	function turnToRegist(){
		window.location = "/voc_info/showRegist";
	}
</script>
</head>
<body>
	<div class="container" style="margin-top: 10px">

		<!--  header start -->
		<div style="height:80px;margin-top: 40px;
			background: url('/voc_info/res/images/logo-login.png') no-repeat">
		</div>
		<!--  header end -->

		<div id="div_body" class="row-fluid div-body" style="margin-top: 20px;height:500px;background-image: url(/voc_info/res/images/login_bg.jpg);border-radius:10px 10px">
			<div id="div_login_body" style="background-color:white;width:300px;height:350px;position: relative;z-index:2;left:600px;top:75px;border-radius:10px 10px">
				<form id="form_login" style="padding-top:40px">
					<table style="border-collapse: collapse;">
						<tr>
							<td><img src="/voc_info/res/images/user.png" /><strong style="font-size:12pt">用户名：</strong></td>
						</tr>
						<tr>
							<td><input id="username" type="text" name="username" placeholder="请输入用户名" style="margin-bottom: 0"/></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td><img src="/voc_info/res/images/pwd.png" /><strong style="font-size:12pt">密码：</strong></td>
						</tr>
						<tr>
							<td><input id="password" type="password" name="password" placeholder="请输入密码" style="margin-bottom: 0" /></td>
						</tr>
					</table>
					
					<div id="error_field" style="position:absolute;left:40px;top:230px;">
					</div>
					<div style="position:absolute;left:40px;top:270px;">
						<button type="button" class="btn btn-info" style="width:220px;height:30px" onclick="login();">登陆</button>
						<br/>
						<a href="###" style="position: relative;left: 160px;top:10px" onclick="turnToRegist();">免费注册</a>
					</div>
				</form>
			</div>
		</div>
		
	</div>
</body>
</html>
