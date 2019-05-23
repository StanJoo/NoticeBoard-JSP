<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="content.ContentDBProcess" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="content" class="content.Content" scope="page"/>
<jsp:setProperty name="content" property="contentTitle" />
<jsp:setProperty name="content" property="contentDetail"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 처리</title>
</head>
<body>
<%
	String userId = null;
	if (session.getAttribute("userId") != null){
		userId = (String) session.getAttribute("userId");
	}
	 
	if(content.getContentTitle() == null || content.getContentDetail() == null ){
		PrintWriter script = response.getWriter();
		script.println("<script>alert('입력이 안된 부분이 있습니다')</script>"); 
		script.println("<script>history.back()</script>"); 
	} else {
		ContentDBProcess contentProc = new ContentDBProcess();
		int result = contentProc.write(content.getContentTitle(), userId, content.getContentDetail());
		if( result == -1 ){ 
			PrintWriter script = response.getWriter();
			script.println("<script>alert('글쓰기에 실패하였습니다')</script>"); 
			script.println("<script>history.back()</script>"); 
		} else { 
			PrintWriter script = response.getWriter();
			script.println("<script>location.href = 'content.jsp'</script>");
		}
	}
%>
</body>
</html>