<?xml version="1.0" encoding="ISO-8859-1" ?>
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
out.println("<input type=\"text\" value=\"Search\" id=\"searchbar\" onfocus=\"if (this.value == 'Search') {this.value = '';}\">");
out.println("</form>");
out.println("</div>");
out.println("<h1> Welcome "+ user.getName()  +"</h1>");
out.println("<img src="+user.getPhotoURL()+" width=10% height=10% >"); 
out.println("<br>");
out.println("<body>");
out.println("<a href=\"Messages.jsp\">Go to Messages</a>");
out.println("<br><a href=\"MessageFriends.jsp\">Message Friends</a>");
out.println("<br><a href=\"CreateQuiz.jsp\">Create a Quiz</a>");
out.println("<br><a href=\"QuizList.jsp\">Take a Quiz</a>");
out.println("<form action=\"UpdatePhotoServlet\" method=\"post\">");
out.println("<p><input type=\"text\" name=\"newURL\" value=\"Enter url of new photo\" onfocus=\"if (this.value == 'Enter url of new photo') {this.value = '';}\">");
out.println("<input type=\"submit\" value=\"Change photo\">");
out.println("</form>");
%>



</body>
</html>