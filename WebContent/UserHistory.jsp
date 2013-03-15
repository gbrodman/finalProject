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
<%String user = request.getParameter("username"); 
int numQuizzesTaken = QuizResultUtils.numQuizzesTaken(user);
double averageScore = QuizResultUtils.getAverageScore(user);
List<QuizResult> results = QuizResultUtils.getAllResultsByUser(user);
%>
<title>User History for <%out.print(user); %></title>
</head>
<body>
<h2>Basic Stats: </h2><br>
<%
out.println("Number of quizzes taken: " + numQuizzesTaken + "<br>");
out.println("Average score: " + MyDB.formatDouble(averageScore) + "<br>");

out.println("<h2 class=\"h2bar recentquizzesh2\">Taken Quizzes</h2>");
out.println("<div class=\"quizlist\" id=\"recentquizbar\">");
out.println("<ul class=\"recentquizclass\">");
out.println("<li>");
out.println("<div class=\"quiz top\">");
out.println("<div class=\"name\">Title</div>");
out.println("<div class=\"createdby\">Created By</div>");
out.println("<div class=\"takequiz\">");
out.println("Take Quiz");
out.println("</div>");
out.println("<div class=\"highscore\">Your Score</div>");
out.println("<div class=\"numplays\">Number of Plays</div>");
out.println("<div class=\"category\">Category</div>");
out.println("</div>");
out.println("</li>");
for (int i = 0; i < results.size(); i++) {
	System.out.println("hai");
	QuizResult result = results.get(i);
	Quiz quiz = QuizUtils.getQuizByID(result.getQuizID());
	out.println("<li>");
	out.println("<div class=\"quiz\">");
	out.println("<div class=\"name\">");
	out.println(quiz.getTitle());
	out.println("</div>");
	out.println("<div class=\"createdby\">");
	out.println(quiz.getOwner().getName());
	out.println("</div>");
	out.println("<div class=\"takequiz\">");
	out.print("<form action=\"DisplayQuizServlet\" method=\"post\">");
	out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
	out.print(quiz.getId());
	out.print("\">");
	out.print("<input type=\"image\" src=\"QuizMePictures/QuizMe.png\"/></form>");
	out.println("</div>");
	out.println("<div class=\"highscore\">");
	out.println(result.getScore());
	out.println("</div>");
	out.println("<div class=\"numplays\">");
	out.println(quiz.getNumPlays());
	out.println("</div>");
	out.println("<div class=\"category\">");
	out.println(quiz.getCategory());
	out.println("</div>");
	out.println("</div>");
	out.println("</li>");
}
out.println("</ul>");
out.println("</div>");%>

</body>
</html>