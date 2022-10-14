<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
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
if (userID == null){ //로그인이 안되잇는 사람은 로그인 할수있도록 해준다.
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
}
else{
	if(bbs.getBbsTitle()  == null || bbs.getBbsContent() == null){ //빈 항목이 있으면 입력이 안된 사항이라고 뒤로 보내준다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); //뒤로가기
				script.println("</script>");
			} else{
			BbsDAO bbsDAO = new BbsDAO();
			
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); //변수를 입력받은 값들이 매개변수로 들어감
			
			if(result==-1){ //데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}     
			else  { //성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='bbs.jsp'"); //회원가입되면 main페이지로
				script.println("</script>");
			}
}
		
		}
	%>
</body>
</html>