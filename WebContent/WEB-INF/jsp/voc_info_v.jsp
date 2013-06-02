<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="zh-en">
<head>
<meta charset="utf-8">
<title>个人词汇信息</title>

<script src="/voc_info/res/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script src="/voc_info/res/js/jquery.paginate.js" type="text/javascript"></script>
<link href="/voc_info/res/css/bootstrap.min.css" rel="stylesheet">
<link href="/voc_info/res/css/style.css" rel="stylesheet">

<style type="text/css">
body {
	background: url('/voc_info/res/images/cloudsbg.jpg');
	background-repeat:repeat-x;
}

.div-head {
	background: url('/voc_info/res/images/bg_head.jpg');
}

.div-body {
	background-color: white;
}
</style>

<script type="text/javascript">
	var userId = "";
	var nickname = "";
	var username = "";
	var email = "";

	$(function(){
		//获得用户信息
		userId = $("#hidden_user_id").val();
		nickname = $("#hidden_nickname").val();
		username = $("#hidden_username").val();
		email = $("#hidden_email").val();

		//显示基本信息
		$("#span_user_id").html(userId);
		$("#span_nickname").html(nickname);
		$("#span_username").html(username);
		$("#span_email").html(email);

		//获得最近十个复习单词
		getRecentTenWords();
		//获得上一次选择的级别
		getLastBand();

		//获得用户词汇量
		getVocabulary();

		//获得所做练习的信息
		getUserExers(0);
		//获得随机推荐的试题
		getRandomExers();
	});

	//获得最近十个复习单词
	function getRecentTenWords(){
		$.getJSON("/voc_info/getRecentTenWords?&userId="+userId+"&rand="
				+Math.random(),function(data){
			for(var i=0;i<data.words.length;i++){
				$("#div_vocabulary_"+(i%4)).append("<div style='font-size:12pt;margin-top:5px'>"+data.words[i]+"</div>");
			}
		});
	}
	//获得上一次选择的级别
	function getLastBand(){
		$.getJSON("/voc_info/getUserBand?userId="+userId+"&rand="+Math.random(),function(data){
			if(data.band == "-1"){
				$("#select_band :first-child").attr("selected","selected");
			}else{
				$("#select_band :nth-child("+(parseInt(data.band)+1)+")").attr("selected","selected");
			}
		});
	}

	//获得用户词汇量
	function getVocabulary(){
		$.getJSON("/voc_info/getVocabulary?userId="+userId+"&rand="+Math.random(),function(data){
			if(data.voc == -1){
				$("#span_vocabulary_test").html("您还未进行过词汇量测试。");
			}else{
				$("#span_vocabulary_test").html(data.voc+" - "+(parseInt(data.voc)+200));
			}
		});
	}
	
	//获得所做练习的信息
	function getUserExers(pageNo){
		//清空
		$("#tbody_scores").html("");
		$("#div_scores_pagination").html("");
		
		//每页显示个数
		var countPerPage = 5;
		
		$.getJSON("/voc_info/getUserExers?userId="+userId+"&pageNo="+pageNo+"&rand="+Math.random(),
			function(data){
				for(var i=0;i<data.exers.length;i++){
					var tr = $("<tr></tr>");
					if(i % 2 == 0){
						tr.addClass("success");
					}else{
						tr.addClass("error");
					}
					var td1 = $("<td>"+(pageNo*countPerPage+i+1)+"</td>");
					var td2 = $("<td>"+data.exers[i][1]+"</td>");
					var td3 = $("<td></td>");
					if(data.exers[i][0] == -1){
						td3.append("未完成");
					}else{
						td3.append(data.exers[i][0]);
					}
					var td4 = $("<td>"+data.exers[i][2].replace("T"," ")+"</td>");
					var td5 = $("<td><a href='/voc_exer/showExpadding?userId="+userId+"&serialNumber="+data.exers[i][1]+"'>重做</a>"+
							"</td>");
					if(data.exers[i][0] != -1){
						td5.append("<a style='margin-left:10px' href='/voc_exer/showExpadding?userId="+userId+"&serialNumber="+data.exers[i][1]+"&isReview=1'>复习</a>");
					}
					
					tr.append(td1);
					tr.append(td2);
					tr.append(td3);
					tr.append(td4);
					tr.append(td5);
					$("#tbody_scores").append(tr);
				}

				//分页
				if(data.exers.length > 0){
					createUserExersPagination(pageNo);
				}
			}
		);
	}
	//所做练习信息分页
	function createUserExersPagination(pageNo){
		$.getJSON("/voc_info/getCountPages?userId="+userId+"&rand="+Math.random()
			,function(data){
			$("#div_scores_pagination").paginate({
				count 					: data.count,
				start 					: pageNo+1,
				display    				: 5,
				border					: true,
				border_color			: '#0f9ed6',
				text_color  			: '#fff',
				background_color    	: '#79c9ec',	
				border_hover_color		: '#ccc',
				text_hover_color  		: '#000',
				background_hover_color	: '#fff', 
				images					: false,
				mouse					: 'press',
				onChange     			: function(page){
										  	getUserExers(page-1);
										  }
			});
		});
	}
	//获得随机推荐的试题
	function getRandomExers(){
		//题目套数
		var numExer = 10;
		
		$.getJSON("/voc_info/getRandomExers?numExer="+numExer+"&rand="+Math.random()
			,function(data){
			for(var i=0;i<data.ids.length;i++){
				var tr = $("<tr class='warning'></tr>");
				var td1 = $("<td>v-31-"+data.ids[i]+"</td>");
				var td2 = $("<td><a href='/voc_exer/showExpadding?userId="+userId+"&serialNumber=v-31-"+data.ids[i]+"'>做题</a></td>");
				tr.append(td1);
				tr.append(td2);
				$("#tbody_exer_"+(i%2)).append(tr);
			}
		});
	}

	//转向词汇本
	function goToVocbook(){
		var band = $("#select_band :selected").val();
		
		//记录用户所选级别
		$.ajax({
			url:"/voc_info/saveUserBand?userId="+userId+"&theBand="+band+"&rand="+Math.random(),
			type:"get",
			success:function(data,textValue){
				//转向词汇本
				window.location = "/voc_book/showNormal?userId="+userId+"&theBand="+band+"&model=0";				
			}
		});
	}

	//转向词汇量测试
	function goToVocTest(){
		window.location = "/voc_test/showPage?userId="+userId;
	}

	//转向词汇练习
	function goToVocExer(){
		//题目套数
		var numExer = 1;
		
		$.getJSON("/voc_info/getRandomExers?numExer="+numExer,function(data){
			window.location = "/voc_exer/showExpadding?userId="+userId+"&serialNumber=v-31-"+data.ids[0];	
		});
	}
	
	function exit(){
		$.getJSON("/voc_info/logout",
			function(data){
			if(!data.success){
				alert("未知错误！");
			}else{
				alert("退出成功！");
				window.location = "/voc_info/showLogin";
			}
		});
	}
</script>

<!--[if IE 6]>
	<link href="/voc_info/res/css/ie6.min.css" rel="stylesheet">
<![endif]-->

</head>
<body>
	<!-- navbar -->
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<img src="/voc_info/res/images/bingo.png" style="float:left">
			<a class="brand" href="###" >英语词汇本</a>
			<ul class="nav">
				<li class="active"><a href="javascript:void(0);">个人词汇信息</a></li>
				<li><a id="a_vocbook" href="javascript:void(0);" onclick="goToVocbook();">词汇本</a></li>
				<li><a id="a_voc_test" href="javascript:void(0);" onclick="goToVocTest();">词汇量测试</a></li>
				<li><a id="a_voc_exe" href="javascript:void(0);" onclick="goToVocExer();">词汇练习</a></li>
			</ul>
			<div style="float:right;margin:10px 10px">
				<a href="javascript:void(0);" onclick="exit();">退出</a>
			</div>
		</div>
	</div>
	<!-- navbar end -->
	
	<div class="container"
		style="margin-top: 40px; z-index: 1;">

		<!-- head -->
		<div id="div_head" class="div-head"
			style="color: white; font-size: 35pt; padding: 5px;width:930px ; height: auto;">
			<img src="/voc_info/res/images/people.png"> <span style="margin-left: 2%">个人词汇信息</span>
		</div>
		<!-- head end -->
		
		<!-- general info -->
		<div style="background-image: url(/voc_info/res/images/small_head.png); height: 40px; width: 930px;margin-top: 30px;font-size:20pt;color:white;padding-left: 10px">
			<img src="/voc_info/res/images/user.png" style="width: 40px;height: 40px">
			基本信息
		</div>
		<div style="background-color: #dcf0f9;padding:10px 0 10px 10px">
			<div style="font-size:13pt">
				<strong>账号：</strong><span id="span_username"></span><br>
				<strong>昵称：</strong><span id="span_nickname" style="color:orange"></span><br>
				<strong>邮箱：</strong><span id="span_email"></span><br>
				<strong>用户ID：</strong><span id="span_user_id" style="color:green"></span><br>
			</div>
		</div>
		<!-- general info end -->
		
		<!-- vocabulary book -->
		<div style="background-image: url(/voc_info/res/images/small_head.png); height: 40px; width: 930px;margin-top: 30px;font-size:20pt;color:white;padding-left: 10px">
			<div style="float:right;margin:5px 5px 0 0">
				<select id="select_band" style="margin-bottom:0;width:150px">
					<option value="0">CET - 4</option>
					<option value="1">CET - 3</option>
					<option value="2">CET - 6</option>
					<option value="3">PETS - 1</option>
					<option value="4">PETS - 2</option>
					<option value="5">PETS - 3</option>
					<option value="6">PETS - 4</option>
					<option value="7">PETS - 5</option>
					<option value="8">研究生英语</option>					
				</select>
				<input type="button" class="btn" value="前往词汇本" onclick="goToVocbook();">
			</div>
			<img src="/voc_info/res/images/dictionary.png" style="width: 40px;height: 40px">
			词汇本
		</div>
		<div style="background-color: #dcf0f9;padding:10px 10px 10px 10px">
			<div style="font-size:13pt"><strong>最近复习的十个单词：</strong></div><br>
			<div class="row-fluid" style="background-color:#96d2ed;">
				<div id="div_vocabulary_0" class="span3" align="center"></div>
				<div id="div_vocabulary_1" class="span3" align="center"></div>
				<div id="div_vocabulary_2" class="span3" align="center"></div>
				<div id="div_vocabulary_3" class="span3" align="center"></div>
			</div>
		</div>
		<!-- vocabulary book end -->
		
		<!-- vocabulary test -->
		<div style="background-image: url(/voc_info/res/images/small_head.png); height: 40px; width: 930px;margin-top: 30px;font-size:20pt;color:white;padding-left: 10px">
			<div style="float:right;margin:5px 5px 0 0">
				<input type="button" class="btn " value="前往测试" onclick="goToVocTest();">
			</div>
			<img src="/voc_info/res/images/test.png" style="width: 40px;height: 40px">
			词汇量测试
		</div>
		<div style="background-color: #dcf0f9;padding:10px 0 10px 10px">
			<div style="font-size:13pt"><strong>词汇量：</strong><span id="span_vocabulary_test"></span></div>
		</div>
		<!-- vocabulary test end -->
		
		<!-- vocabulary exercises -->
		<div style="background-image: url(/voc_info/res/images/small_head.png); height: 40px; width: 930px;margin-top: 30px;font-size:20pt;color:white;padding-left: 10px">
			<img src="/voc_info/res/images/book.png" style="width: 40px;height: 40px">
			词汇练习
		</div>
		<div style="background-color: #dcf0f9;padding:10px 10px 10px 10px">
			<div style="font-size:13pt"><strong>所做的所有练习：</strong></div><br>
			<div style="background-color: #dddddd">
				<table class="table table-hover" style="margin-bottom:10px">
					<thead>
						<tr>
							<td>序号</td>
							<td>试卷编号</td>
							<td>分数</td>
							<td>做题时间</td>
							<td>操作</td>
						</tr>
					</thead>
					<tbody id="tbody_scores"></tbody>
				</table>			
				<div id="div_scores_pagination"></div>
			</div><br>
			<div style="font-size:13pt;padding-top:10px"><strong>随机推荐试题：</strong></div><br>
			<div class="row-fluid" >
				<div id="div_exer_0" class="span6" style="background-color: #dddddd">
					<table class="table table-bordered">
						<thead>
							<tr>
								<td>试卷编号</td>
								<td>链接</td>
							</tr>
						</thead>
						<tbody id="tbody_exer_0"></tbody>
					</table>	
				</div>
				<div id="div_exer_1" class="span6" style="background-color: #dddddd">
					<table class="table table-bordered ">
						<thead>
							<tr>
								<td>试卷编号</td>
								<td>链接</td>
							</tr>
						</thead>
						<tbody id="tbody_exer_1"></tbody>
					</table>	
				</div>
			</div>
		</div>
		<!-- vocabulary exercises end -->
		
	</div>
	<form>
		<input id="hidden_user_id" type="hidden" value='<s:property value="userId" />'>
		<input id="hidden_nickname" type="hidden" value='<s:property value="nickname" />'>
		<input id="hidden_username" type="hidden" value='<s:property value="username" />'>
		<input id="hidden_email" type="hidden" value='<s:property value="email" />'> 
	</form>

	<script>
		$(function(){if($.browser.msie&&parseInt($.browser.version,10)===6){$('.row div[class^="span"]:last-child').addClass("last-child");$(':button[class="btn"], :reset[class="btn"], :submit[class="btn"], input[type="button"]').addClass("button-reset");$(":checkbox").addClass("input-checkbox");$('[class^="icon-"], [class*=" icon-"]').addClass("icon-sprite");$(".pagination li:first-child a").addClass("pagination-first-child")}})
	</script>
</body>
</html>
