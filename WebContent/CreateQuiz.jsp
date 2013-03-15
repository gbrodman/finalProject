<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="database.MessageUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,servlets.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Create a Quiz</title>
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
<h1>Create New Quiz</h1>
<%

	out.println("<form action=\"CreateNewQuizServlet\" method=\"post\">");
	out.println("<p><input type=\"text\" name=\"quizTitle\" value=\"Enter title of quiz\" onfocus=\"if (this.value == 'Enter title of quiz') {this.value = ''}\">");
	out.println("<br><textarea name=\"quizInstructions\" rows=3 cols=30 onfocus=\"if (this.value == 'Provide instructions or description of quiz') {this.value = ''}\">Provide instructions or description of quiz</textarea>");
	out.println("<br><input type=\"checkbox\" value=\"random\" name=\"isRandomPages\"> Display questions in random order?");
	out.println("<br><input type=\"checkbox\" value=\"instant\" name=\"isInstantCorrection\"> Instantly correct answers?");
	out.println("<br><input type=\"checkbox\" value=\"practice\" name=\"canPractice\"> Allow practice mode?");
	out.println("<p><input type=\"text\" name=\"quizCategory\" value=\"Enter quiz category\" onfocus=\"if (this.value == 'Enter quiz category') {this.value = ''}\">");
	out.println("<br><textarea name=\"quizTags\" rows=3 cols=30 onfocus=\"if (this.value == 'Enter tags separated by spaces.') {this.value = ''}\">Enter tags separated by spaces.</textarea>");
	out.println("<br><input type=\"submit\" value=\"Create Quiz\">");
	out.println("</form>");
	
%>
</body>
</html>