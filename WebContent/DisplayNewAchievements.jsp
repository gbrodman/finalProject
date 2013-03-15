<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Display New Achievements</title>
</head>
<body>
<%
	User user = (User)session.getAttribute("user");
	String username = user.getName();	

	Achievement achievement = (Achievement)session.getAttribute("achievement");
	out.println("<h1>Congratulations, you earned a new achievement!</h1>");

	out.println("<br><img src=\""+achievement.getPhotoURL()+"\" width=10% height=10% >   <strong>"+achievement.getName()+" :</strong> "+achievement.getText());

	out.println("<br><br><form action=\"Homepage.jsp\" >");
	out.println("<input type=\"submit\" value=\"Continue\">");
	out.println("</form>");

%>
</body>
</html>