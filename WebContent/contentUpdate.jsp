<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="content.Content"%>
<%@ page import="content.ContentDBProcess"%>
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
<title>게시글 수정하기</title>
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
		int contentNum = 0;
		if (request.getParameter("contentNum") != null) {
			contentNum = Integer.parseInt(request.getParameter("contentNum"));
		}
		if (contentNum == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('유효하지 않는 게시물입니다')</script>");
			script.println("<script>location.href = 'content.jsp'</script>");
		}
		Content content = new ContentDBProcess().getContent(contentNum);
	%>

	<form method="post"
		action="contentUpdateProcess.jsp?contentNum=<%=contentNum%>">
		<div class="container">
			<h2>게시글 수정</h2>
			<table class="table table-hover">
				<tbody>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="글 제목" name="contentTitle" maxlength="40"
							value="<%=content.getContentTitle()%>"></td>
					</tr>
					<tr>
						<td><textarea type="text" class="form-control"
								placeholder="글 내용을 작성하세요" name="contentDetail" maxlength="1024"
								style="height: 400px;"><%=content.getContentDetail()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
		</div>
	</form>
</body>
</html>