<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*,database.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey'
	rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Quiz Administration</title>
</head>
<body>

<%
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	String title = quiz.getTitle();
	out.println("<h1>Admin Utils for " + title + "</h1>");
	out.println("<br><form action=\"QuizAdminServlet\" method=\"post\">");
	out.println("<input type=\"submit\" value=\"Delete history\">");
	%>
	<input type="hidden" name="action" value="deleteHistory"/></form>
	<% 
	/*
	out.print("<form action=\"QuizAdminServlet.jsp\" method=\"post\">");
	out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
	out.print(quiz.getId());
	out.print("\">");
	out.print("<input type=\"submit\" value=\"Delete this quiz\" /></form>");
	*/
	out.println("<br><form action=\"QuizAdminServlet\" method=\"post\">");
    out.println("<input type=\"submit\" value=\"Delete this quiz\">");
    out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
	out.print(quiz.getId());
	out.print("\">");
	%>
	<input type="hidden" name="action" value="deleteQuiz"/></form><br>
	<form action="DisplayQuiz.jsp" method="get">
	<input type="submit" value="Back to quiz page">
	</form>

</body>
</html>