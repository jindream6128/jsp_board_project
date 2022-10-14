<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID"/>  
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String userID = null; //로그인이 된사람은  또다시 회원가입 할수 없도록 막아준다.
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if (userID != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인이 되어있습니다..')");
	script.println("location.href = 'mian.jsp'");
	script.println("</script>");
}

		if(user.getUserID()  == null || user.getUserPassword() == null || user.getUserName() == null
		   || user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter(); //하나라도 입력이 되어 있지 않은 사항이 있다면 입력이 안 된 사항이라는 문구와 함께 뒤로가게 된다.
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //뒤로가기
			script.println("</script>");
		} else{
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.join(user); //변수를 입력받은 값들이 매개변수로 들어감
		
		if(result==-1){ //기본키를 primary ID로 해서 중복인 ID를 만들수 없다. 이때 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}     
		else  { //비밀번호가 다를때 
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'"); //회원가입되면 main페이지로 이동
			script.println("</script>");
		}
		}
	%>
</body>
</html>