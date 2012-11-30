<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="header">
  <div id="head_top">
    <div id="head_top_right">
      <form class="form-search">
        <div class="input-append">
          <input type="text" class="span2 search-query">
          <button type="submit" class="btn">Search</button>
        </div>
      </form>
    </div>
    <div id="head_top_left">
    </div>
  </div>
  <div id="head_mid">
    <a href="main.jsp"><img src="img/logo.jpg" alt="logo"></a>
  </div>
  <div id="head_bot">
     <a href="about.jsp">About</a> |  
     <% if(session.getAttribute("userid") == null) {%>
     <a href="login.jsp">Login</a> | <a href="signup.jsp">Sign up</a> 
     <%}else{ %>
     <%=session.getAttribute("username")%>님 | <a href="photo.jsp">Upload</a> | <a href="logout.jsp">Logout</a>
     <%} %>
  </div>
</div>
<div id="navbar">
  <div class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category</a> |
      <ul class="dropdown-menu">
        <li><a href="Animal.html">Animal</a></li>
        <li><a href="Car.html">Car</a></li>
        <li><a href="Fashion.html">Fashion</a></li>
        <li><a href="Food">Food</a></li>
        <li><a href="Humor.html">Humor</a></li>
        <li><a href="Nature.html">Nature</a></li>
        <li><a href="People.html">People</a></li>
        <li><a href="Sports.html">Sports</a></li>
        <li><a href="Extra.html">Extra</a></li>
      </ul>
    <a href="#">Newest</a>
  </div>
</div>