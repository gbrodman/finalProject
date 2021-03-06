<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="questions.Question"%>
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
	Question question;
	if (!takeQuiz.isRandom()) question = takeQuiz.nextQuestion();
	else question = takeQuiz.getRandomNext();

	if (question == null) {
		takeQuiz.quizComplete();
		out.println("<h1>Congrats, you finished the quiz!</h1>");
		out.println("<form action=\"ViewResults.jsp\">");
		out.println("<br><input type=\"submit\" value=\"View Your Results!\">");
		out.println("</form>");
	}
	else {
		if (takeQuiz.isInstantCorrect()) out.println(question.getInstantQuestion());
		else out.println(question.getQuestionDisplay());
	}
%>
</body>
</html>