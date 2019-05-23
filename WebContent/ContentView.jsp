<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="content.Content" %>
<%@ page import="content.ContentDBProcess" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>게시판 내용</title>
</head>
<body>
	<%
		String userId = null;
		if(session.getAttribute("userId") != null){
			userId = (String) session.getAttribute("userId");
		}
		int contentNum = 0;
		if(request.getParameter("contentNum") != null){
			contentNum = Integer.parseInt(request.getParameter("contentNum"));
		}
		if(contentNum == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('유효하지 않는 게시물입니다')</script>"); 
			script.println("<script>location.href = 'content.jsp'</script>"); 
		}
		Content content = new ContentDBProcess().getContent(contentNum);
	%>

<div class="container">
  <h2>게시판 글 보기</h2>          
  <table class="table table-hover">
    <tbody>
      <tr>
      	<td>글 제목</td>
      	<td><%= content.getContentTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      </tr>
      <tr>
      	<td>작성자</td>
      	<td><%= content.getContentUser() %></td>
      </tr>
      <tr>
      	<td>작성일자</td>
      	<td><%= content.getContentDate().substring(0, 11) + content.getContentDate().substring(11, 13) + "시 " + content.getContentDate().substring(14, 16) + "분 " %></td>
      </tr>
      <tr>
      	<td>글 내용</td>
        <td><%= content.getContentDetail().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
      </tr>
    </tbody>
  </table>
  <a href = "content.jsp" class="btn btn-primary">목록</a>
  <%
  	if(userId != null && userId.equals(content.getContentUser())){
  %>
  	<a href="contentUpdate.jsp?contentNum=<%=contentNum %>" class="btn btn-primary">수정</a>
 	<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="contentDeleteProcess.jsp?contentNum=<%=contentNum %>" class="btn btn-primary">삭제</a>
  <%
  	}
  %>
</div>
</body>
</html>