<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDBProcess"%>
<%@ page import = "java.util.ArrayList" %>
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
<title>회원리스트</title>
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
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<div class="container">
		<h2>회원리스트</h2>

		<table class="table table-hover">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
				</tr>
			</thead>
			<tbody>
				<%
					UserDBProcess userDBProcess = new UserDBProcess();
					ArrayList<User> list = 	userDBProcess.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getUserId()%></td>
					<td><%=list.get(i).getUserName()%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			if (pageNumber != 1) {
		%>
		<a href="content.jsp?pageNumber=<%=pageNumber - 1%>"
			class="btn btn-success btn-arraw-left">이전</a>
		<%
			}
			if (userDBProcess.nextPage(pageNumber + 1)) {
		%>
		<a href="content.jsp?pageNumber=<%=pageNumber + 1%>"
			class="btn btn-success btn-arraw-left">다음</a>
		<%
			}
		%>
		<a href="content.jsp" class="btn btn-primary">목록</a>
	</div>
</body>
</html>