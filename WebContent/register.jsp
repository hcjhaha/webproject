<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	Class.forName("com.mysql.jdbc.Driver");
	
	String dbUrl = "jdbc:mysql://localhost:3306/wp";
	String dbUser = "black";
	String dbPassword = "mustache";
	
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("inputid");
	String pwd = request.getParameter("inputpassword");
	String pwd_confirm = request.getParameter("inputpasswordconfirm");
	String name = request.getParameter("inputname");
	String email = request.getParameter("inputemail");
	String birthday = request.getParameter("inputbirthday");
	String phone = request.getParameter("inputphone");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (userid == null || userid.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	}
	
	if (pwd == null || pwd.length() < 5) {
		errorMsgs.add("비밀번호는 5자 이상 입력해주세요.");
	} 
	
	if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	}
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	
	if (phone == null || phone.trim().length() == 0) {
		errorMsgs.add("핸드폰번호를 입력해주세요.");
	}
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO users(userid, name, pwd, email, birthday, phone) " +
					"VALUES(?, ?, ?, ?, ?, ?)"
					);
			stmt.setString(1,  userid);
			stmt.setString(2,  name);
			stmt.setString(3,  pwd);
			stmt.setString(4,  email);
			stmt.setString(5,  birthday);
			stmt.setString(6,  phone);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
			}
		} catch (SQLException e) {
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
  	<jsp:param name="current" value="register"/>
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
	 			<b><%= name %></b>님 등록해주셔서 감사합니다.
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