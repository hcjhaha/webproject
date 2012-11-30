<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
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
  </head>
  <body>
    <div id="body_wrap">
 	  <jsp:include page="include/header.jsp" flush="true">
  		<jsp:param name="current" value="main"/>
		</jsp:include>
      <div id="center">
      </div>
      <div id= "footer">
        Designed by Black Mustache
      </div>
    </div>
  </body>
</html>