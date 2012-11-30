<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/wp";
	String dbUser = "black";	
	String dbPassword = "mustache";
	
	int pageNo = 1;
	
	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException ex) {}
	
	int numInPage = 9;											
	int startPos = (pageNo - 1) * numInPage; 	
	int numItems, numPages;
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
	<jsp:include page="include/header.jsp" flush="true">
  	<jsp:param name="current" value="index"/>
	</jsp:include>
  <div id="center">
 	<%
 	try {
	    Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.createStatement();
		
 		rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
		rs.next();
		numItems = rs.getInt(1);
		numPages = (int) Math.ceil((double)numItems / (double)numInPage);
		rs.close();
		stmt.close();
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM users ORDER BY name LIMIT " + startPos + ", " + numInPage);
 	%>
 		<div class="row">
			<div class="span12 page-info">
				<div class="pull-left">
					Total <b><%=numItems %></b> users 
				</div>
				<div class="pull-right">
					<b><%= pageNo%></b> page / total <b><%= numPages %></b> pages
				</div>
 			</div>
 		</div>
		<table class="table table-bordered table-stripped">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Birthday</th>
					<th>Phone</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()) {
			%>
				<tr>
					<td><a href="show.jsp?id=<%=rs.getInt("id")%>"><%=rs.getString("userid") %></a></td>
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getString("email") %></td>
					<td><%=rs.getString("birthday") %></td>
					<td><%=rs.getString("phone") %></td>
					<td>
						<a href="signup.jsp?id=<%=rs.getInt("id")%>" class="btn btn-mini">modify</a>
						<a href="#" class="btn btn-mini btn-danger" data-action="delete" data-id="<%=rs.getInt("id") %>" >delete</a>
					</td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>

		<div class="pagination pagination-centered">
      <ul>
      	<%
      	int startPageNo, endPageNo;
      	int delta = 5;
      	startPageNo = (pageNo <= delta) ? 1: pageNo - delta;
      	endPageNo = startPageNo + (delta * 2) + 1;
      	
      	if (endPageNo > numPages) {
      		endPageNo = numPages;
      	}
      	
      	if (pageNo <= 1) { 
      	%>
        	<li class="disabled"><a href="#">&laquo;</a></li>
        <% 
      	} else {
        %>
        	<li><a href="index.jsp?page=<%= pageNo - 1%>">&laquo;</a></li>
        <%
        } 
      	
        String className = "";
        for(int i = startPageNo; i <= endPageNo; i++) {
        	className = (i == pageNo) ? "active" : "";
        	out.println("<li class='" + className + "'>");
        	out.println("<a href='index.jsp?page=" + i + "'>" + i + "</a>");
        	out.println("</li>");
        }
        
      	if (pageNo >= numPages) { 
      	%>
        	<li class="disabled"><a href="#">&raquo;</a></li>
        <% 
      	} else {
        %>
        	<li><a href="index.jsp?page=<%= pageNo + 1%>">&raquo;</a></li>
        <%
        } 
        %>
     </ul>
    </div>
		<%
		} catch (SQLException e) {
			out.print("<div class='alert'>" + e.getLocalizedMessage() + "</div>");
		}finally {
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
		%>
  </div>
<jsp:include page = "include/footer.jsp" />
</div>
</body>

<script>
$("a[data-action='delete']").click(function() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		location = 'delete.jsp?id=' + $(this).attr('data-id');
	}
	return false;
});
</script>
</html>