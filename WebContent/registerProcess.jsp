<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDBProcess" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId" />
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userName"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 처리</title>
</head>
<body>
<%
	if(user.getUserId() == null || user.getUserPassword() == null ||
	   user.getUserEmail() == null || user.getUserName() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>alert('입력이 안된 부분이 있습니다')</script>"); 
		script.println("<script>history.back()</script>"); 
	} else {
		UserDBProcess userProc = new UserDBProcess();
		int result = userProc.register(user);
		if( result == 1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>location.href = 'login.jsp'</script>");
		} else if ( result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('이미 존재하는 이메일입니다')</script>"); 
			script.println("<script>history.back()</script>"); 
		}
	}
%>
</body>
</html>