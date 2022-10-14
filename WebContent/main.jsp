<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
String userID =null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID"); //session에 있는 값을 그대로 가져온다.
}
%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbaer - toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
				<span class = "icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>	
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) {//로그인이 안되어 있는 사람들은 로그인 할수 네비게이션을 만들어 준다.
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li> 
					</ul>
				</li>
			</ul>
			<%
				} else{ //여긴 로그인이 되어있는 사람들이 볼수있는 화면
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%	
				}
			%>
			
		
		</div>
	</nav>
	
	<div class="container">
		<div class ="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>이 웹 사이트는 부경대학교 학생이 공부한 JSP 웹사이트 입니다. <br>진근이의 첫번째 웹 프로젝트 입니다.</p>
				<p><a class="btn btn-primary btn-pull" href = "https://blog.naver.com/jindream6128" role="button">시작 합니다 !</a></p>
			</div>
		</div>
	</div>
	<%//사진을 불러와서 보여준다 %>
	<div class="container">
		<div id="myCarousel" class="carousel" data-ride="carousel">
			<ol class="carousel - indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			</ol>
			<div class="carousel-inner">
				<div calss="item active">
					<img src="images/1.jpg">
				</div>
			</div>
			<%//여러개의 이미지가 있을경우 %>
			<a class ="left carousel-control" href=#myCarousel" data-slide="prev">
				<span class="glyphicon-chevron-left"></span>
			</a>
				<a class ="right carousel-control" href=#myCarousel" data-slide="next">
				<span class="glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>