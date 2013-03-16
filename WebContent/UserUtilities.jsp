<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="database.MessageUtils"%>
<%@page import="database.QuizUtils"%>
<%@page import="database.QuizResultUtils"%>
<%@page import="database.UserUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>User Utilities</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
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

<h1>Settings</h1>
<h3>User Info</h3>
<% 
out.println("<div class=\"profileimg\"> <img src=" +user.getPhotoURL()+" id=\"profilepicture\"></div>");//width=10% height=10% >"); 
out.println("<form action=\"UpdatePhotoServlet\" method=\"post\">");
out.println("<p><input type=\"text\" name=\"newURL\" value=\"Enter new photo URL\" onfocus=\"if (this.value == 'Enter new photo URL') {this.value = '';}\">");
out.println("<input type=\"submit\" value=\"Change photo URL\">");
out.println("</form><br>");
out.println("About Me is currently: " + user.getAboutMe());
out.println("<form action=\"UpdateAboutMeServlet\" method=\"post\">");
out.println("<p><input type=\"text\" name=\"aboutMe\" value=\"Enter your new description\" onfocus=\"if (this.value == 'Enter your new description') {this.value = '';}\">");
out.println("<input type=\"submit\" value=\"Change About Me\">");
out.println("</form><br>");
%>
<h3>Privacy</h3>
Friends will always be able to see all your activity and your profile.<br>
<form action="ChangePrivacyServlet" method="post">
<input type="radio" name="setting" value="0"> All users can see everything about you.<br>
<input type="radio" name="setting" value="1"> Non-friends cannot see your profile, you show up as Anonymous on results.<br>
<input type="radio" name="setting" value="2"> Your presence is invisible to non-friends.<br>
<input type="submit" value="Change privacy setting"><br>
</form>

<% if (user.isAdmin()) {
	out.println("<h1>Admin</h1>");
	out.println("<h2>Statistics:</h2>");
	out.println("<p>");
	out.println("Number of users: " + UserUtils.getNumberTotalUsers() + " <br></p>");
	out.println("<p>Number quizzes taken: " + QuizResultUtils.totalNumQuizzesTaken() + "<br></p>");
	out.println("<h2>Admin Utils:</h2>");
	out.println("<ul><li>Remove User: <br>");
	out.println("<form method=\"post\" action=\"RemoveUserServlet\">");
	out.println("<input type=\"text\" name=\"userToRemove\" value=\"User to remove\" onfocus=\"if (this.value == 'User to remove') {this.value = '';}\"/>");
	out.println("<input type=\"submit\" value=\"Remove\"/>");
	out.println("</form></li><li>Create Announcement: <br>");
	out.println("<form method=\"post\" action=\"CreateAnnouncementServlet\">");
	out.println("<input type=\"text\" name=\"announcement\" value=\"Announcement\" onfocus=\"if (this.value == 'Announcement') {this.value = '';}\"/>");
	out.println("<input type=\"submit\" value=\"Create\"/>");
	out.println("</form>");
	out.println("</li><li>");
	out.println("Promote User Account to Admin: <br>");
	out.println("<form method=\"post\" action=\"PromoteUserServlet\">");
	out.println("<input type=\"text\" name=\"userToPromote\" value=\"User to promote\" onfocus=\"if (this.value == 'User to promote') {this.value = '';}\"/>");
	out.println("<input type=\"submit\" value=\"Promote\"/>");
	out.println("</form></li></ul>");
}
%>


</body>
</html>