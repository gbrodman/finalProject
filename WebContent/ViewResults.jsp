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
	Quiz quiz = takeQuiz.getQuiz();
	int quizID = quiz.getId();
	User user = (User)session.getAttribute("user");
	String username = user.getName();
	
	List<Achievement> achievements = AchievementUtils.getAchievementsForUser(username);
	boolean hasTopScore = false;
	boolean hasPractice = false;
	for (Achievement a : achievements) {
		if (a.getID() == 5) hasTopScore = true;
		if (a.getID() == 4) hasPractice = true;
	}

	int topScore = 0;
	if (QuizResultUtils.getNumberTimesQuizTaken(quizID) > 0) topScore = QuizResultUtils.getBestScore(quizID);
	
	boolean second = false;
	if (takeQuiz.getScorePercent() > topScore && !hasTopScore) {
		out.println("<h1>Congratulations, you earned a new achievement!</h1>");
		Achievement achievement = AchievementUtils.getAchievement(5);
		out.println("<br><img src=\""+achievement.getPhotoURL()+"\" width=10% height=10% >   <strong>"+achievement.getName()+" :</strong> "+achievement.getText());
		AchievementUtils.addAchievement(username, 5);
		second = true;
	}
	
	int numQuizzesTaken = QuizResultUtils.numQuizzesTaken(username);
	if (numQuizzesTaken == 9) {
		if (!second) out.println("<h1>Congratulations, you earned a new achievement!</h1>");
		Achievement achievement = AchievementUtils.getAchievement(3);
		out.println("<br><img src=\""+achievement.getPhotoURL()+"\" width=10% height=10% >   <strong>"+achievement.getName()+" :</strong> "+achievement.getText());
		AchievementUtils.addAchievement(username, 3);
		second = true;
	}
	
	if (!hasPractice && takeQuiz.isPractice()) {
		if (!second) out.println("<h1>Congratulations, you earned a new achievement!</h1>");
		Achievement achievement = AchievementUtils.getAchievement(4);
		out.println("<br><img src=\""+achievement.getPhotoURL()+"\" width=10% height=10% >   <strong>"+achievement.getName()+" :</strong> "+achievement.getText());
		AchievementUtils.addAchievement(username, 4);
		second = true;
	}

	out.println("<h1>Results:</h1>");
	if (takeQuiz.isPractice()) out.println("Don't worry, this was just a practice!");
	List<Question> questions = takeQuiz.getQuestions();
	if (!takeQuiz.isPractice())
		QuizResultUtils.saveResultInDatabase(username, quizID,takeQuiz.getScorePercent(),takeQuiz.getTimeUsed(), takeQuiz.getTimeCompleted());
	int[] scores = takeQuiz.getScores();
	out.println("<ol>");
	for (int i = 0; i < scores.length; i++) {
		out.println("<li>Score: "+scores[i]+"/"+questions.get(i).getPointValue()+"</li>");
	}
	out.println("</ol>");
	
	out.println("Your total score is: " +takeQuiz.getScorePercent()+"%");
	out.println("<br>You took " +QuizResult.timeUsedToString(takeQuiz.getTimeUsed())+" to complete this quiz.");
	
	out.println("<br><br><form action=\"ChallengeFriend.jsp\" >");
	out.println("<input type=\"submit\" value=\"Challenge a friend to take this quiz!\">");
	out.println("</form>");
	out.println("<br><br><form action=\"DisplayQuiz.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Quiz Page\">");
	out.println("</form>");
	out.println("<br><form action=\"Homepage.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Homepage\">");
	out.println("</form>");
%>
</body>
</html>