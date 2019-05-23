<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDBProcess"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userId" />
<jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<%
		UserDBProcess userProc = new UserDBProcess();

		int result = userProc.login(user.getUserId(), user.getUserPassword());
		if (result == 1) {
			session.setAttribute("userId",user.getUserId());
			PrintWriter script = response.getWriter();
			script.println("<script>location.href = 'content.jsp'</script>");
		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('패스워드가 일치하지 않습니다')</script>");
			script.println("<script>history.back()</script>");
		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('존재하지 않는 아이디입니다')</script>");
			script.println("<script>history.back()</script>");
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('DB 오류 발생')</script>");
			script.println("<script>history.back()</script>");
		}
	%>
</body>
</html>