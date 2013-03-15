<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Picture-Response Question</title>
</head>
<body>
<%
	out.println("<h1>Create new Picture-Response Question</h1>");

	out.println("<form action=\"CreatePRQuestionServlet\" method=\"post\">");
	//out.println("<p><input type=\"title\" name=\"qrquestionTitle\" value=\"Enter title of question\">"); question title?
	out.println("<br><textarea name=\"questionBody\" rows=3 cols=30 >Enter prompt for quiz-taker.</textarea>");
	out.println("<br><input name=\"photoURL\"> Enter URL of photo.");
	out.println("<br><textarea name=\"questionAnswer\" rows=3 cols=30 >Enter possible answers with each answer surrounded by brackets</textarea>");
	out.println("<br><input name=\"questionPoints\"> Enter point value of question.");
	out.println("<br><input type=\"submit\" value=\"Create Question\">");
	out.println("</form>");
	
%>
</body>
</html>