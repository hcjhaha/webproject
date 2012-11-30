<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" import="org.apache.commons.lang3.StringUtils" %>
<%
	String errorMsg = null;	
	String actionUrl;
	
	Connection conn = null;	
	PreparedStatement stmt = null;	
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/wp";	
	String dbUser = "black";	
	String dbPassword = "mustache";
	
	String userid = "";
	String pwd = "";
	String name = "";
	String email = "";
	String birthday = "";
	String phone = "";
	
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}

	if (id > 0) {
		actionUrl = "update.jsp";
		try {
		 	Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

			stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
			stmt.setInt(1, id);
			
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				userid = rs.getString("userid");
				pwd = rs.getString("pwd");
				name = rs.getString("name");
				email = rs.getString("email");
				birthday = rs.getString("birthday");
				phone = rs.getString("phone");
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}else {
		actionUrl = "register.jsp";
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
    <jsp:include page="include/header.jsp" flush="true">
			<jsp:param name="current" value="Sign Up" />
		</jsp:include>
     <% if (errorMsg != null && errorMsg.length() > 0 ) {
    	 		out.print("<div class='alert'>" + errorMsg + "</div>"); 
    	 	} %>
      <div id="center">
      	<% if (id <= 0) { %>
      	<form class="form-horizontal" id="signup" method="post" action="register.jsp">
      	<% }else { %>
      	<form class="form-horizontal" id="signup" method="post" action="update.jsp">
      		<input type="hidden" name="id" value="<%= id %>">
      	<% }  %>
        <div class="control-group">
            <label class="control-label" for="inputId">ID</label>
          <div class="controls">    
            <input type="text" id="inputid" name="inputid" placeholder="id" value="<%=userid%>">    
          </div>  
        </div>
        <% if (id <= 0) { %>
	        <div class="control-group">   
	          <label class="control-label" for="inputPassword">Password</label>
	            <div class="controls">
	              <input type="password" name="inputpassword" placeholder="Password">
	            </div>
	        </div>
	        <div class="contro-group">
	          <label class="control-label" for="inputPassword">Password Confirm</label>
	            <div class="controls">
	              <input type="password" id="inputPassword_confirm" placeholder="Password Confirm" name="inputpasswordconfirm">
	            </div>  
	        </div><br>
        <% } %>
	        <div class="control-group">    
	            <label class="control-label" for="inputname">이름</label>
	          <div class="controls">   
	            <input type="text" id="inputname" placeholder="Name" name="inputname" value="<%=name %>">    
	          </div>  
	        </div>
	        <div class="control-group">    
	            <label class="control-label" for="inputEmail">E-mail</label>
	          <div class="controls">    
	            <input type="text" id="inputEmail" placeholder="Email" name="inputemail" value="<%=email %>">
	          </div>  
	        </div> 
	        <div class="control-group">    
	            <label class="control-label" for="inputBirthday">생일</label>
	          <div class="controls">    
	          	<input type="text" id="inputbirthday" placeholder="Birthday" name="inputbirthday" value="<%=birthday %>">
	          </div>  
	        </div>  
	        <div class="control-group">    
	            <label class="control-label" for="inputname">핸드폰</label>
	          <div class="controls">   
	         		<input type="text" id="inputphone" placeholder="Phone" name="inputphone" value="<%=phone %>">
	          </div>
	        </div>     
	        <div class="control-group">  
	          <div class="controls">
	          <% if (id <= 0) { %>
	            <input type="submit" class="btn" value="회원가입">
	          <% } else { %>
	          	<input type="submit" class="btn" value="수정">
	          <% } %>   
	            <button type="reset" class="btn">다시입력</button>    
	          </div>
       		</div>
        </form>
      </div>
    <jsp:include page="include/footer.jsp" flush="true"></jsp:include>
    </div>
  </body>
</html>
