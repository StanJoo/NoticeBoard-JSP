<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDBProcess"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 삭제 처리</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('회원정보를 수정할 수 없습니다.')</script>");
			script.println("<script>location.href = 'login.jsp'</script>");
		}
		
	
		UserDBProcess userProc = new UserDBProcess();
		int result = userProc.userDelete(userId); 
		if (result == -1) { 
			PrintWriter script = response.getWriter();
			script.println("<script>alert('글 삭제에 실패하였습니다')</script>");
			script.println("<script>history.back()</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>location.href = 'logoutProcess.jsp'</script>");
		}
	%>
</body>
</html>