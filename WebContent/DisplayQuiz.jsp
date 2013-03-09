<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Quiz</title>
</head>
<%
	TakeQuiz takeQuiz = (TakeQuiz)session.getAttribute("takeQuiz");
	Quiz quiz = takeQuiz.getQuiz();
	String inst = quiz.getInstructions();
	String title = quiz.getTitle();
	int num = quiz.numQuestions();
	out.println("<h1>"+title+"</h1>");
	out.println("<body><br>"+inst);
	out.println("<br>This quiz has "+num+" questions.");
	out.println("<form action=\"ViewQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Start the Quiz!\">");
	out.println("</form>");
%>
</body>
</html>