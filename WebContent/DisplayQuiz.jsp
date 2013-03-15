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
<title>Display Quiz</title>
</head>
<%
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	User user = (User)session.getAttribute("user");	
	int id = quiz.getId();
	String inst = quiz.getInstructions();
	String title = quiz.getTitle();
	int num = quiz.numQuestions();
	out.println("<h1>"+title+"</h1>");
	out.println("<body><br>Created by: "+quiz.getOwner().getName());
	out.println("<body><br>"+inst);
	out.println("<br>This quiz has "+num+" questions.");
	if (quiz.isInstantCorrection()) out.println("<br>This quiz has instant correction.");
	out.println("<form action=\"TakeQuizServlet\" method=post>");
	out.println("<br><input type=\"submit\" value=\"Start the Quiz!\">");
	out.println("</form>");
	if (quiz.isCanPractice()) {
		out.println("<form action=\"PracticeModeServlet\" method=post>");
		out.println("<br><input type=\"submit\" value=\"Practice the Quiz\">");
		out.println("</form>");
	}
	out.println("<br><form action=\"QuizList.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Quizzes\">");
	out.println("</form>");
	out.println("<br><form action=\"Homepage.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Homepage\">");
	out.println("</form>");
	if (user.isAdmin()) {
		out.println("<br><form action=\"QuizAdmin.jsp\">");
		out.println("<input type=\"submit\" value=\"Quiz Administration\">");
		out.println("</form>");
	}
	out.println("<br><br><h1>Past Results</h1>");
	out.println("<br>This quiz has been taken "+QuizResultUtils.getNumberTimesQuizTaken(id)+" times with an average score of "+QuizResultUtils.getAverageScoreOnQuiz(id)+"%");
	out.println("<br><br>Your past results:<br>");
	List<QuizResult> userResults = QuizResultUtils.getPerformancesByUser(user.getName(), id, quiz.getNumPlays());
	out.println("<ul>");
	for (QuizResult result : userResults) {
		out.println("<li>Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
	}
	out.println("</ul>");
	out.println("<br>All time highest performers:<br>");
	List<QuizResult> allTimeBestResults = QuizResultUtils.getTopPerformances(id, 5); //can change numResults to display
	out.println("<ul>");
	for (QuizResult result : allTimeBestResults) {
		String ru = result.getUser();
		out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
	}
	out.println("</ul>");
	out.println("<br>Recent high performers:<br>");
	List<QuizResult> recentTopResults = QuizResultUtils.getTopRecentPerformances(id, 5); //can change numResults to disply
	out.println("<ul>");
	for (QuizResult result : recentTopResults) {
		String ru = result.getUser();
		out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
	}
	out.println("</ul>");
	out.println("<br>Recent test results:<br>");
	List<QuizResult> recentResults = QuizResultUtils.getRecentPerformances(id, 5); //can change numResults to disply
	out.println("<ul>");
	for (QuizResult result : recentResults) {
		String ru = result.getUser();
		out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
	}
	out.println("</ul>");
%>
</body>
</html>