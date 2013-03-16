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
<title>Quiz Results</title>
</head>
<body>
<% 
User user = (User) session.getAttribute("user");
int num_notes = MessageUtils.getNumberUnreadNotes(user.getName());
int num_friend_requests = MessageUtils.getNumberFriendRequests(user.getName());
int num_challenges = MessageUtils.getNumberUnreadChallenges(user.getName());
int total_num = num_notes + num_friend_requests + num_challenges;
out.println("<div id=\"navbar\">");
out.println("<ul>");
out.println("<li><a href=\"Homepage.jsp\" class=\"topbarlinks\">Home</a></li>");
out.println("<li><a href=\"Messages.jsp\" class=\"topbarlinks messagetopbarlinks\">Messages  </a><span class=\"numNotifications\">" + total_num + "</span></li>");
out.println("<li><a href=\"CreateQuiz.jsp\" class=\"topbarlinks\">Create a Quiz</a></li>");
out.println("<li><a href=\"MessageFriends.jsp\" class=\"topbarlinks\">Friends</a></li>");
out.println("<li><a href=\"QuizList.jsp\" class=\"topbarlinks\">Take a Quiz</a></li>");
out.println("<li><a href=\"LogoutServlet\" class=\"topbarlinks\">Logout</a></li>");
out.println("</ul>");
out.println("<form method=\"post\" action=\"SearchServlet\">");
out.println("<input type=\"text\" name=\"searchtext\" value=\"Search\" id=\"searchbar\" onfocus=\"if (this.value == 'Search') {this.value = '';}\">");
out.println("</form>");
out.println("</div>");

out.println("<div class=\"messagenotification\">");
out.println("Notes: " + num_notes);
out.println("<br>");
out.println("Friend Requests: " + num_friend_requests);
out.println("<br>");
out.println("Challenges: " + num_challenges);
out.println("</div>");
%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
	$('div').hide(1);
	$('div').show(800);
	$('.messagenotification').hide();
});
$('.messagetopbarlinks').mouseenter(function() {
	$('.messagenotification').css("width",$('.messagetopbarlinks').width() + 110 + "px");
	$('.messagenotification').css("left", $('.messagetopbarlinks').offset().left - 55 + "px");
	$('.messagenotification').css('position', 'absolute');
	$('.messagenotification').show(400);
});
$('.messagetopbarlinks').mouseleave(function() {
	$('.messagenotification').hide(400);
});
</script>
<%
	TakeQuiz takeQuiz = (TakeQuiz)session.getAttribute("takeQuiz");
	Quiz quiz = takeQuiz.getQuiz();
	int quizID = quiz.getId();
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
	out.print("<br><br><form action=\"DisplayQuiz.jsp\">");
	out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
	out.print(quiz.getId());
	out.print("\">");
	out.print("<input type=\"submit\" value=\"Return to Quiz Page\" /></form></li>");
	
	out.println("<br><form action=\"Homepage.jsp\">");
	out.println("<input type=\"submit\" value=\"Return to Homepage\">");
	out.println("</form>");
%>
</body>
</html>