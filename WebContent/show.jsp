<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
    import="org.apache.commons.lang3.StringUtils"%>
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
  String name = "";
  String pwd = "";
  String email = "";
  String birthday = "";
  String phone = "";

  int id = 0;
  try {
    id = Integer.parseInt(request.getParameter("id"));
  } catch (Exception e) {}

  if (id > 0) {
    try {
        Class.forName("com.mysql.jdbc.Driver");

      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

      stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
      stmt.setInt(1, id);
      
      rs = stmt.executeQuery();
      
      if (rs.next()) {
        userid = rs.getString("userid");
        name = rs.getString("name");
        pwd = rs.getString("pwd");
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
  } else {
    errorMsg = "ID가 지정되지 않았습니다.";
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
    <script src="js/jquery-1.8.3.min.js"></script>
  </head>
<body>

<div id="body_wrap">
	<jsp:include page="include/header.jsp">
  	<jsp:param name="current" value="show"/>
	</jsp:include>
 <div id="center">
 <%
 if (errorMsg != null && errorMsg.length() > 0 ) {
    out.print("<div class='alert'>" + errorMsg + "</div>");
 } else {
 %>
    <div>
      <h3><%=name %></h3>
      <ul>
        <li>User ID: <%=userid %></li>
        <li>Birthday: <%=birthday %></li>
        <li>Email: <a href="mailto:<%=email%>"><%=email %></a></li>
        <li>Phone: <%=phone %></li>
      </ul>
    </div>      
<% } %>
	  <div class="form-actions">
	    <a href="index.jsp" class="btn">목록으로</a>
	    <% if (id > 0) { %>
  	    <a href="signup.jsp?id=<%=id %>" class="btn btn-primary">수정</a>
	     <a href="#" class="btn btn-danger" data-action="delete" data-id="<%=id %>" >삭제</a>
	    <% } %>
	  </div>
		<script>
		  $("a[data-action='delete']").click(function() {
		    if (confirm("정말로 삭제하시겠습니까?")) {
		      location = 'delete.jsp?id=' + $(this).attr('data-id');
		    }
		    return false;
		  });
		</script>  
  </div>
  <jsp:include page = "include/footer.jsp" />
</div>
</body>
</html>