<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    %>
<%
	String errorMsg = null;
	int result = 0;
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/wp";
	String dbUser = "black";
	String dbPassword = "mustache";
	
	request.setCharacterEncoding("utf-8");

	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	
	try {
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("DELETE FROM users WHERE id=?");
		stmt.setInt(1,  id);
		
		result = stmt.executeUpdate();
		if (result != 1) {
			errorMsg = "삭제에 실패했습니다.";
		}
	} catch (SQLException e) {
		errorMsg = "SQL 에러: " + e.getMessage();
	} finally {
		if (rs != null) try{rs.close();} catch(SQLException e) {}
		if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		if (conn != null) try{conn.close();} catch(SQLException e) {}
	}
%>    

<!DOCTYPE html>
<html>
  <head>
    <title>Magnetic Board</title>
    <link href="bootstrap.min.css" rel="stylesheet" media="screen">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/reset.css" rel="stylesheet" type="text/css">
    <meta charset="utf-8">
  </head>
<body>
<div id="body_wrap">
 	<jsp:include page="include/header.jsp">
  	<jsp:param name="current" value="delete"/>
	</jsp:include>
 	<div id="center">
 		<% if (errorMsg != null) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<%= errorMsg %>
 			</div>
	 	<% } else { %>
	 		<div class="alert alert-success">
	 			사용자 정보를 삭제하였습니다.
	 		</div>
	 	<%}%>
	 		<div class="form-action">
	 			<a href="index.jsp" class="btn">목록으로</a>
	 		</div>
 	</div>
 	<jsp:include page = "include/footer.jsp" />
</div>
</body>
</html>