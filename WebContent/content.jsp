<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "content.ContentDBProcess" %>
<%@ page import = "content.Content" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>게시판</title>

<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
	String userId = null;
	if(session.getAttribute("userId") != null){
		userId = (String) session.getAttribute("userId");
	}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<%
 		if(userId == null){
 	%>      
 	<a href="login.jsp" class="btn btn-online pull-right">로그인 및 회원가입</a>
 	<%
 		} else { 
 	%>
 			<a href="logoutProcess.jsp" class="btn btn-online pull-right">로그아웃</a>
 			<a href="userInfo.jsp" class="btn btn-online pull-right">회원정보</a>
 			<a href="userList.jsp" class="btn btn-online pull-right">회원목록</a>
 			
        <%
 		}
        %>

<div class="container">
  <h2>게시판</h2>    
        
  <table class="table table-hover">
    <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>글쓴이</th>
        <th>작성일</th>
      </tr>
    </thead>
    <tbody>
    	<%
    		ContentDBProcess contentDBProcess = new ContentDBProcess();
   			ArrayList<Content> list = contentDBProcess.getList(pageNumber);
   			for(int i=0; i<list.size(); i++){		
   		%>
   		    <tr>
        	<td><%= list.get(i).getContentNum() %></td>
        	<td><a href="ContentView.jsp?contentNum=<%= list.get(i).getContentNum() %>"><%= list.get(i).getContentTitle() %></a></td>
        	<td><%= list.get(i).getContentUser() %></td>
        	<td><%= list.get(i).getContentDate().substring(0, 11) + list.get(i).getContentDate().substring(11, 13) + "시 " + list.get(i).getContentDate().substring(14, 16) + "분 " %></td>
     	 	</tr>
   		<%
   			}
    	%>
    </tbody>
  </table>
  <% 
  	if(pageNumber != 1){
  %>
  	<a href="content.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
  <%
  	} if(contentDBProcess.nextPage(pageNumber + 1)) {
  %>
  	<a href="content.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
  <%
  	}
  %>
  <a href="contentWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
</div>
</body>
</html>