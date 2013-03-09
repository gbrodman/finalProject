<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,servlets.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<title>Create a Quiz</title>
</head>
<body>
<%
	User user = (User)session.getAttribute("user");

	out.println("<form action=\"CreateNewQuizServlet\" method=\"post\">");
	out.println("<p><input type=\"text\" name=\"quizTitle\" value=\"Enter title of quiz\">");
	out.println("<br><textarea name=\"quizInstructions\" rows=3 cols=30 >Provide instructions or description of quiz</textarea>");
	out.println("<br><input type=\"checkbox\" name=\"isRandomPages\"> Display questions in random order?");
	out.println("<br><input type=\"checkbox\" name=\"isInstantCorrection\"> Instantly correct answers?");
	out.println("<br><input type=\"checkbox\" name=\"canPractice\"> Allow practice mode?");
	out.println("<p><input type=\"text\" name=\"quizCategory\" value=\"Enter quiz category\">");
	out.println("<br><textarea name=\"quizTags\" rows=3 cols=30 >Enter tags seperated by spaces. </textarea>");
	out.println("<br><input type=\"submit\" value=\"Create Quiz\">");
	out.println("</form>");
	
%>
</body>
</html>