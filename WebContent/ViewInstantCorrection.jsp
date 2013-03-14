<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question results</title>
</head>
<body>
<%
	TakeQuiz takeQuiz = (TakeQuiz)session.getAttribute("takeQuiz");
	Question question = takeQuiz.getCurrentQuestion();
	String ans = (String)session.getAttribute("lastAnswer");

	out.println(question.getInstantCorrectResult(ans));
%>
</body>
</html>