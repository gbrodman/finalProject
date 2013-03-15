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
<title>View question</title>
</head>
<body>
<%
	TakeQuiz takeQuiz = (TakeQuiz)session.getAttribute("takeQuiz");
	User user = (User)session.getAttribute("user");
	
	out.println("<h1>Challenge Friend</h1>");
	
	List<String> friends = FriendUtils.getFriends(user.getName());
	
	out.println("Which friends would you like to challenge?");
	
	out.println("<br><form action=\"SendMessageServlet\" method=\"post\">");
	for (String friend : friends) {
		out.println("<input type=\"checkbox\" name=\""+friend+"\" value=\""+friend+"\"> "+friend+"<br>");
	}
	out.println("<input type=\"hidden\" name=\"messageType\" value=\"challenge\"/>");
	out.println("<input type=\"submit\" value=\"Send Challenge!\">");
	out.println("</form>");
	out.println("<br><form action=\"ViewResults.jsp\">");
	out.println("<input type=\"submit\" value=\"Cancel\">");
	out.println("</form>");
%>
</body>
</html>