<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>회원가입</title>
<style>
.container {
	margin: 0 auto;
	width: 100%;
}

.btn {
	display: block;
	width: 300px;
	margin: 0 auto;
}

input {
	display: block;
	width: 300px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<div class="container">
		<form method="post" action="registerProcess.jsp">
			<h2 style="text-align: center;">회원가입</h2>
			<p>
				<input type="text" name="userId" placeholder="아이디">
			</p>
			<p>
				<input type="password" name="userPassword" placeholder="비밀번호">
			</p>
			<p>
				<input type="text" name="userEmail" placeholder="이메일">
			</p>
			<p>
				<input type="text" name="userName" placeholder="이름">
			</p>
			<p>
				<input class="btn btn-primary" type="submit" value="회원가입">
				<input class="btn btn-default" type="button" value="로그인으로 돌아가기"
					onClick="location.href='login.jsp';">
			</p>
		</form>
	</div>
</body>
</html>