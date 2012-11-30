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
			<jsp:param name="current" value="about" />
		</jsp:include>
    <div id="center">
      <div id="about">
        <div id="big">
          Magnetic Board ?
          <div id="mag_bar">
          </div>
        </div>
          : 사진공유를 기반으로 한 SNS 서비스
          <br><br><br>
        <div id="big2">
          Black Mustache ?
          <div id="black_bar">      
          </div>
        </div>
         : 명지대학교 컴퓨터공학과 웹 프로그래밍 5조 조원<br>　최진욱, 황철재, 안다희, 서혜인, 이현선
      </div>
    </div>
    <jsp:include page="include/footer.jsp" flush="true"></jsp:include>
    </div>
  </body>
</html>