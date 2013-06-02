<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%><!DOCTYPE html>
<html lang="zh-en">
<head>
<meta charset="utf-8">
<title>用户注册</title>

<script src="/voc_info/res/js/jquery-1.8.2.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/jquery-ui-1.9.2.custom.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="/voc_info/res/js/validation-regist.js" type="text/javascript"></script>

<link href="/voc_info/res/css/jquery-ui-1.10.1.custom.min.css"
	rel="stylesheet">
<link href="/voc_info/res/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
.error {
	color: red;
}

label.error i {
	background-image: url(/voc_info/res/images/regist_icons.png);
	background-position: 0 0;
	width: 16px;
	height: 16px;
	display: inline-block;
	margin-top: 5px
}

label.valid i {
	background-image: url(/voc_info/res/images/regist_icons.png);
	background-position: 0 -200px;
	width: 16px;
	height: 16px;
	display: inline-block;
	margin-top: 5px
}
</style>

<script type="text/javascript">
	function saveUser(){
		if($("#form_regist").valid()){
			$.ajax({
				url:"/voc_info/saveUser",
				type:"post",
				dataType:"json",
				data:{
					username:$("#username").val(),
					password:$("#password").val(),
					nickname:$("#nickname").val(),
					email:$("#email").val()
				},
				success:function(data,textState){
					if(data.success){
						$("#div_regist_body").hide();
						$("#div_step").css("background-position","0 -35px");
						$("#div_regist_result").html("恭喜，注册成功！"+
							"5秒钟后或<a href='###' onclick='turnToLogin();'>点此</a>"+
							"将前往登陆页面");
						window.setTimeout(function(){turnToLogin();},5000);
					}else{
						$("#div_regist_body").hide();
						$("#div_regist_result").html("注册失败！请稍后重试。"+
							"5秒钟后或<a href='###' onclick='turnToRegist();'>点此</a>"+
							"将返回注册页面");
						window.setTimeout(function(){turnToRegist();},5000);
					}
				}
			});
		}
	}

	function turnToRegist(){
		$("#div_regist_result").hide();
		$("#div_regist_body").show();
	}

	function turnToLogin(){
		window.location = "/voc_info/showLogin";
	}
</script>
</head>
<body>
	<div class="container" style="margin-top: 10px">

		<!-- header start -->
		<div style="height:80px;margin-top: 10px">
			<img src="/voc_info/res/images/logo.png"/>
			<span style="height:80px;color:#5492e7;font-size:20pt;margin-left:20px">用户注册</span>
		</div>
		<!-- header end -->

		<div id="div_body" class="row-fluid div-body" style="margin-top: 20px;
			background-image: url('/voc_info/res/images/regist_bg.jpg');
			background-position: 150px 25px;*background-position: 170px 25px;">
			<div id="div_step"
				style="width: 940px; height: 35px; display: block; background-image: url(/voc_info/res/images/step.png); background-position: 0 0px"></div>
			<div id="div_regist_body" style="position: relative;">
				<div style="margin: 20px 0 0 30px">
					<span style="color: red">*</span>为必填项
					<span style="position: relative;left:670px">
						我已注册，返回<a href="###" onclick="turnToLogin();">登陆</a>界面
						<i class="icon-share-alt"></i>
					</span>
				</div>
				<form id="form_regist" class="form-horizontal" style="margin-top: 40px">
					<div class="control-group">
						<label class="control-label"><span style="color: red">*</span>用户名：</label>
						<div style="float: left; margin-left: 20px">
							<input id="username" name="username" type="text"
								placeholder="6-20个字符">
						</div>
						<div style="float: left; margin-left: 20px"></div>
					</div>
					<div class="control-group">
						<label class="control-label"><span style="color: red">*</span>密码：</label>
						<div style="float: left; margin-left: 20px">
							<input id="password" name="password" type="password"
								placeholder="6-20个字符">
						</div>
						<div style="float: left; margin-left: 20px"></div>
					</div>
					<div class="control-group">
						<label class="control-label"><span style="color: red">*</span>密码确认：</label>
						<div style="float: left; margin-left: 20px">
							<input id="password2" name="password2" type="password"
								placeholder="请再次输入密码">
						</div>
						<div style="float: left; margin-left: 20px"></div>
					</div>
					<div class="control-group">
						<label class="control-label"><span style="color: red">*</span>昵称：</label>
						<div style="float: left; margin-left: 20px">
							<input id="nickname" name="nickname" type="text" placeholder="请输入昵称">
						</div>
						<div style="float: left; margin-left: 20px"></div>
					</div>
					<div class="control-group">
						<label class="control-label"><span style="color: red">*</span>邮箱：</label>
						<div style="float: left; margin-left: 20px">
							<input id="email" name="email" type="text" placeholder="请输入邮箱">
						</div>
						<div style="float: left; margin-left: 20px"></div>
					</div>
					<div class="control-group">
						<label class="control-label"></label>
						<div style="float: left; margin-left: 20px; *margin-left: 40px">
							<button type="button" class="btn btn-info" style="width: 220px ; height:40px" onclick="saveUser();">同意协议并注册</button>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label"></label>
						<div style="float: left; margin-left: 20px">
							<textarea rows="4" cols="35" readonly="readonly"
								style="resize: none; cursor: default;">协议。。。</textarea>
						</div>
					</div>
				</form>
				<div style="position: absolute;left:670px;*left:690px;top:330px">
					<div style="font-size:15px"><strong>温馨提示：</strong></div>
					<div style="margin-top:20px;width:250px">请如实填写个人信息，并记住所填帐号和密码。</div>
				</div>
			</div>
			<div id="div_regist_result" style="margin-top: 40px"></div>
		</div>

	</div>
</body>
</html>
