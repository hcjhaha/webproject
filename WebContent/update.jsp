<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
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
	String userid = request.getParameter("inputid");
	String name = request.getParameter("inputname");
	String email = request.getParameter("inputemail");
	String birthday = request.getParameter("inputbirthday");
	String phone = request.getParameter("inputphone");

	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (userid == null || userid.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	}
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE users " +
					"SET  userid=?, name=?, email=?, birthday=?, phone=? " +
					"WHERE id=?"
					);
			stmt.setString(1,  userid);
			stmt.setString(2,  name);
			stmt.setString(3,  email);
			stmt.setString(4,  birthday);
			stmt.setString(5,  phone);
			stmt.setInt(6,  id);
			
			result = stmt.executeUpdate();			
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getStackTrace());
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
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
  <jsp:param name="current" value="update"/>
</jsp:include>
 	<div id="center">
 		<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%= name %></b>님 정보가 수정되었습니다.
	 		</div>
		 	<div class="form-action">
		 		<a href="index.jsp" class="btn">목록으로</a>
		 	</div>
	 	<%}%>
 	</div>
 	<jsp:include page = "include/footer.jsp" />
</div>
</body>
</html>