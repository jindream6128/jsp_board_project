<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.Bbs" %>
<%@ page import = "bbs.BbsDAO" %>
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
	userID = (String) session.getAttribute("userID");
}
int bbsID = 0 ;
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID")); 
}
if (bbsID==0){ //bbsID가 0이면 다시 bbs페이지로 이동시킨다
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않는 글입니다.')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}
Bbs bbs = new BbsDAO().getBbs(bbsID); //구체적인 정보를 BBS안으로 담을수 있도록

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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) {
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
		<div class="row">
			<table class="table table-striped" style="text-align: center; border; 1px solid #dddddd"> 
				<thead>
					<tr>
						<th colspan="3" style="background-color; #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
				<% //작성에 필요한 목록 %>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "&<br>") %></td> 
					<% //replaceAll을 이용해서, html상의 특수문자, 공백들을 처리해준다 -> 이렇게 해주지 않으면 웹브라우저가, html코드인지 게시글의 내용인지 모르므로 공격에 취약해질수 있다. %>
					</tr>	
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td> 
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시"+bbs.getBbsDate().substring(14,16)+"분" %></td> 
					</tr>	
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "&<br>") %></td>  
						<% //replaceAll을 이용해서, html상의 특수문자, 공백들을 처리해준다 -> 이렇게 해주지 않으면 웹브라우저가, html코드인지 게시글의 내용인지 모르므로 공격에 취약해질수 있다. %>
					</tr>	
				</tbody>				
			</table>
			<% //목록으로 다시 돌아갈수 있도록 버튼을 만들어 준다 %>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){ //해당 글의 작성자가 본인인 경우에만 BBSID를 가져와서 수정, 삭제가 가능하도록 만든다
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a><% //수정은 bbsID가 동일한 경우 update.jsp로 이동, 삭제의 경우에도 동일하고 deleteAction으로 이동 %>
			 <% //정말 삭제 할건지 한번 더 물어봐 준다. %>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>