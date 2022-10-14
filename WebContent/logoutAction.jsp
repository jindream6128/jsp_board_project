<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		session.invalidate(); //로그인에 성공하여 부여된 session ID를 빼앗아간다.
	%>
	<script>
		location.href = 'main.jsp'; //main페이지로 이동한다.
	</script>
</body>
</html>