<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="content.Content"%>
<%@ page import="content.ContentDBProcess"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 처리 페이지</title>
</head>
<body>
	<%
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('로그인을 하세요')</script>");
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
		if (request.getParameter("contentTitle") == null || request.getParameter("contentDetail") == null
				|| request.getParameter("contentTitle").equals("")
				|| request.getParameter("contentDetail").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>alert('입력이 안 된 부분이 있습니다')</script>");
			script.println("<script>history.back()</script>");
		} else {
			ContentDBProcess contentProc = new ContentDBProcess();
			int result = contentProc.contentUpdate(contentNum, request.getParameter("contentTitle"),
					request.getParameter("contentDetail"));
			if (result == -1) { 
				PrintWriter script = response.getWriter();
				script.println("<script>alert('글 수정에 실패하였습니다')</script>");
				script.println("<script>history.back()</script>");
			} else { 
				PrintWriter script = response.getWriter();
				script.println("<script>location.href = 'content.jsp'</script>");
			}
		}
	%>
</body>
</html>