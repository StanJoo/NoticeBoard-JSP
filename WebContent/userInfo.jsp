<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDBProcess"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>회원정보</title>
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

		User user = new UserDBProcess().getUser(userId);
	%>

	<div class="container">
		<h2>회원정보</h2>

		<table class="table table-hover">
			<tr>
				<th>아이디</th>
				<td><%=user.getUserId()%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><%=user.getUserPassword()%></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=user.getUserEmail()%></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=user.getUserName()%></td>
			</tr>

		</table>
		<a href="content.jsp" class="btn btn-primary">목록</a>
		<%
			if (userId != null && userId.equals(user.getUserId())) {
		%>
		<a href="userUpdate.jsp?userId=<%=userId%>"
			class="btn btn-primary">수정</a> <a
			onclick="return confirm('정말로 삭제하시겠습니까?')"
			href="userDelete.jsp?userId=<%=userId%>"
			class="btn btn-primary">삭제</a>
		<%
			}
		%>
	</div>
</body>
</html>