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
	int id = Integer.parseInt(request.getParameter("quiz"));
	Quiz quiz = QuizUtils.getQuizByID(id);
	request.getSession().setAttribute("quiz", quiz);
	String inst = quiz.getInstructions();
	String title = quiz.getTitle();
	int num = quiz.numQuestions();
	out.println("<h1>"+title+"</h1>");
	out.println("<br>Created by: ");
	out.println("<a href=\"Profile.jsp?profile=" + user.getName()+ "\">" + user.getName() + "</a>");
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
		String ru = result.getUser(user);
		if (UserUtils.userExists(ru, user)) {
			out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
		}
	}
	out.println("</ul>");
	out.println("<br>Recent high performers:<br>");
	List<QuizResult> recentTopResults = QuizResultUtils.getTopRecentPerformances(id, 5); //can change numResults to disply
	out.println("<ul>");
	for (QuizResult result : recentTopResults) {
		String ru = result.getUser(user);
		if (UserUtils.userExists(ru, user)) {
			out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
		}
	}
	out.println("</ul>");
	out.println("<br>Recent test results:<br>");
	List<QuizResult> recentResults = QuizResultUtils.getRecentPerformances(id, 5); //can change numResults to disply
	out.println("<ul>");
	for (QuizResult result : recentResults) {
		String ru = result.getUser(user);
		if (UserUtils.userExists(ru, user)) {
			out.println("<li>User: "+ru+", Completed at: "+result.getTimeTaken()+", Time Used: "+result.getTimeUsedString()+", Score: "+result.getScore()+"%</li>");
		}
	}
	out.println("</ul>");
%>

</body>
</html>