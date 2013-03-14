<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View question</title>
</head>
<body>
<%
	TakeQuiz takeQuiz = (TakeQuiz)session.getAttribute("takeQuiz");
	User user = (User)session.getAttribute("user");
	
	out.println("<h1>Results:</h1>");
	if (takeQuiz.isPractice()) out.println("Don't worry, this was just a practice!");
	List<Question> questions = takeQuiz.getQuestions();
	if (!takeQuiz.isPractice())
		QuizResultUtils.saveResultInDatabase(user.getName(), takeQuiz.getQuiz().getId(),takeQuiz.getScorePercent(),takeQuiz.getTimeUsed(), takeQuiz.getTimeCompleted());
	int[] scores = takeQuiz.getScores();
	out.println("<br><ol>");
	for (int i = 0; i < scores.length; i++) {
		out.println("<li>Score: "+scores[i]+"/"+questions.get(i).getPointValue()+"</li>");
	}
	out.println("</ol>");
	
	out.println("Your total score is: " +takeQuiz.getScorePercent()+"%");
	out.println("<br>You took " +QuizResult.timeUsedToString(takeQuiz.getTimeUsed())+" to complete this quiz.");
	out.println("<br><br><form action=\"DisplayQuiz.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Quiz Page\">");
	out.println("</form>");
	out.println("<br><form action=\"Homepage.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Homepage\">");
	out.println("</form>");
%>
</body>
</html>