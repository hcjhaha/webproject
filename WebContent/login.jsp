
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"
	import="org.apache.commons.lang3.StringUtils"%>

<!DOCTYPE html>
<html>
<head>
	<title>Magnetic Board</title>
	<link href="bootstrap.min.css" rel="stylesheet" media="screen">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	<meta charset="utf-8">
<style>
.error {background: #936;	color: #fff; padding: 10px;}
</style>
</head>
<body>
	<div id="body_wrap">
		<jsp:include page="include/header.jsp" flush="true">
			<jsp:param name="current" value="login" />
		</jsp:include>
		<div id="center">
			<form action="checklogin.jsp" class="form-horizontal" id="form-login" method="post">
				<div class="control-group">
					<label class="control-label" for="ID">ID</label>
					<div class="controls">
						<input type="text" id="loginid" placeholder="ID" name="loginid">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputPassword">Password</label>
					<div class="controls">
						<input type="password" id="loginpassword" placeholder="Password"
							name="loginpassword">
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<label class="checkbox"> <input type="checkbox">
							Remember me
						</label> <input type="submit" id="loginSubmit" class="btn" value="로그인">
						<a href="signup.jsp" class="btn"> 회원가입 </a>
					</div>
				</div>
			</form>
		</div>
		<jsp:include page="include/footer.jsp" flush="true"></jsp:include>
	</div>
</body>
</html>
