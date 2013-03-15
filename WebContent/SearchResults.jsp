<%@page import="database.MessageUtils"%>
<%@page import="database.FriendUtils"%>
<%@page import="objects.Quiz"%>
<%@page import="java.util.List"%>
<%@page import="objects.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
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
<h1>Search Results</h1>
<%User resultUser = (User) request.getAttribute("userResult");
List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizResults");
if (resultUser != null) {
	out.println("<h2>User Result:</h2>");
	out.println(resultUser.getName());
	String pageToOpen = (resultUser.getPrivacyLevel() > 0 && !FriendUtils.areFriends(resultUser.getName(), user.getName())) ? "Privacy.jsp" : "Profile.jsp";
	%>
	<form action="<%out.print(pageToOpen); %>" method="get">
	<input type="hidden" name="profile" value="<%out.print(resultUser.getName()); %>">
	<input type="hidden" name="otherUser" value="<%out.print(resultUser.getName()); %>">
	<input type="submit" value="View Profile">
	</form>
	<% 
}
if (quizzes != null) {
	out.println("<h2>Quiz Result(s):</h2>");
	for (Quiz quiz : quizzes) {
		out.print("<li>");
		out.print(quiz.getTitle());
		out.print(", by " + quiz.getOwner().getName());
		out.print("<form action=\"TakeQuizServlet\" method=\"post\">");
		out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
		out.print(quiz.getId());
		out.print("\">");
		out.print("<input type=\"submit\" value=\"View this Quiz\" /></form></li>");
	}
}
%>

</body>
</html>