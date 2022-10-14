<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
if (userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
}
int bbsID = 0 ;
if(request.getParameter("bbsID") != null){
	bbsID = Integer.parseInt(request.getParameter("bbsID"));
}
if (bbsID==0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않는 글입니다.')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
}

Bbs bbs = new BbsDAO().getBbs(bbsID);
if(!userID.equals(bbs.getUserID())){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다.')");
	script.println("location.href = 'bbs.jsp'");
	script.println("</script>");
} else{ //권한이 있는사람이라면 성공적으로 넘어온다.
	if(request.getParameter("bbsTitle")  == null || request.getParameter("bbsContent") == null 
				|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){ //bbsTitle이라는 이름으로 넘어온 매개변수를 전부 비교하여 빈값이 있는지 확인한다.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); //뒤로가기
				script.println("</script>");
			} else{
			BbsDAO bbsDAO = new BbsDAO();
			
			int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent") ); //변수를 입력받은 값들이 매개변수로 들어감
			
			if(result==-1){ //데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
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