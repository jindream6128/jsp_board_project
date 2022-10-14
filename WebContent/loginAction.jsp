<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null; 
	if(session.getAttribute("userID") != null){ //로그인에 성공하면 세션 ID를 부여해준다.
		userID = (String) session.getAttribute("userID"); 
	}
	if (userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다..')");
		script.println("location.href = 'main.jsp'"); //이미 로그인 된 사람은 또다시 로그인 못하게 막고 main 페이지로 이동한다.
		script.println("</script>");
	}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result==1){ //로그인 성공
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}     
		else if(result==0){ //비밀번호가 다를때 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){ //아이디가 없을때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){ //데이터베이스 오류일때 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>