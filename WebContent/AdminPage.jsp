<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="database.QuizUtils"%>
<%@page import="database.QuizResultUtils"%>
<%@page import="database.UserUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<% 
User user = (User)session.getAttribute("user");
out.println("<title>" + user.getName()  + "</title>");
out.println("</head>");
out.println("<div id=\"navbar\">");
out.println("<ul>");
out.println("<li><a href=\"Homepage.jsp\" class=\"topbarlinks\">Home</a></li>");
out.println("<li><a href=\"Messages.jsp\" class=\"topbarlinks\">Messages</a></li>");
out.println("<li>Create New Quiz</li>");
out.println("<li><a href=\"MessageFriends.jsp\" class=\"topbarlinks\">Friends</a></li>");
out.println("<li>Take a Quiz</li>");
out.println("</ul>");
out.println("<form method=\"post\" action=\"SearchServlet\">");
out.println("<input type=\"text\" name=\"searchtext\" value=\"Search\" id=\"searchbar\" onfocus=\"if (this.value == 'Search') {this.value = '';}\">");
out.println("</form>");
out.println("</div>");
out.println("<br>");
%>
<body>
<h1>Admin</h1><br>
<h2>Statistics:</h2>
<p>
Number of users:  <%out.println(UserUtils.getNumberTotalUsers()); %><br></p>
<p>Number quizzes taken: <%out.println(QuizResultUtils.totalNumQuizzesTaken()); %><br></p>
<h2>Admin Utils:</h2>
<ul>
<li>
Remove User: <br>
<form method="post" action="RemoveUserServlet">
<input type="text" name="userToRemove" value="User to remove" onfocus="if (this.value == 'User to remove') {this.value = '';}"/>
<input type="submit" value="Remove"/>
</form>
</li><li>
Create Announcement: <br>
<form method="post" action="CreateAnnouncementServlet">
<input type="text" name="announcement" value="Announcement" onfocus="if (this.value == 'Announcement') {this.value = '';}"/>
<input type="submit" value="Create"/>
</form>
</li><li>
Promote User Account to Admin: <br>
<form method="post" action="PromoteUserServlet">
<input type="text" name="userToPromote" value="User to promote" onfocus="if (this.value == 'User to promote') {this.value = '';}"/>
<input type="submit" value="Promote"/>
</form>
</li>
</ul>


</body>
</html>