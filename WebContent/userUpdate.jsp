<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDBProcess"%>
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
<title>회원정보 수정</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('로그인을 하고 접근하세요')</script>");
			script.println("<script>location.href = 'login.jsp'</script>");
		}
		User user = new UserDBProcess().getUser(userId);
	%>

	<form method="post" action="userUpdateProcess.jsp?userId=<%=userId%>">
		<div class="container">
			<h2>회원정보 수정</h2>
			<table class="table table-hover">
				<tbody>
					<tr>
						<td>아이디</td>
						<td><%=user.getUserId()%></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="text" class="form-control"
							placeholder="글 제목" name="userPassword" maxlength="40"
							value="<%=user.getUserPassword()%>"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" class="form-control"
							placeholder="글 제목" name="userEmail" maxlength="40"
							value="<%=user.getUserEmail()%>"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" class="form-control"
							placeholder="글 제목" name="userName" maxlength="40"
							value="<%=user.getUserName()%>"></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="회원정보 수정">
		</div>
	</form>
</body>
</html>