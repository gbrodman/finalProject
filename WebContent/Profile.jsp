<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*,database.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%User viewing = UserUtils.getUser(request.getParameter("profile")); 
User self = (User) session.getAttribute("user");
if (viewing.getPrivacyLevel() > 0 && !FriendUtils.areFriends(viewing.getName(), self.getName())) {
	out.println("<meta http-equiv=\"refresh\" content=\"0;URL=Privacy.jsp?otherUser=" + viewing.getName() + "\">");
}
%>
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey'
	rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<%
List<Achievement> achievements = viewing.getAchievements();
List<QuizResult> recentPerformances = QuizResultUtils.getRecentPerformances(viewing.getName());
List<Quiz> ownedQuizzes = QuizUtils.getQuizzesByUser(viewing.getName(), self);
List<String> friends = FriendUtils.getFriends(viewing.getName());%>
<title><%out.print(viewing.getName()); %>'s profile</title>
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
<h1><%out.print(viewing.getName()); %></h1>
<% 
out.println("<div class=\"profileimgfriends\">");
out.println("<div class=\"profileimg\"><img src=\"" + viewing.getPhotoURL()+ "\"/></div>");
out.println("<div class=\"buttonscontainer\">");
out.println("<div class=\"friendsbutton\">");
if (FriendUtils.getSentRequests(self.getName()).contains(viewing.getName())) {
	out.println("<span class=\"friendspending\">Pending Friend Request</span>");
} else if (FriendUtils.getSentRequests(viewing.getName()).contains(self.getName())){
	out.println("<form method=\"get\" action=\"Messages.jsp\">");
	out.println("<input type=\"submit\" value=\"Respond to friend request!\"");
	out.println("</form");
} else if (FriendUtils.getFriends(self.getName()).contains(viewing.getName())) {
	out.println("<span class=\"alreadyfriends\">Friends!</span>");	
} else {
	out.println("<form method=\"post\" action=\"SendMessageServlet\">");
	out.println("<input type=\"hidden\" name=\"messageType\" value=\"friendRequest\">");
	out.println("<input type=\"hidden\" name=\"to\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"submit\" value=\"Add as friend\">");
	out.println("</form>");
}
out.println("</div>");
out.println("<div class=\"messagebutton\">");

out.println("</div>");
out.println("</div>");
out.println("</div>");


/*if (self.getName().equals(viewing.getName())) {
	out.println("This is you!");
}
else if (FriendUtils.getFriends(self.getName()).contains(viewing.getName())) {
	out.println("You're already friends!<br>");
	out.println("<form method=\"get\" action=\"MessageFriendServlet\">");
	out.println("<input type=\"hidden\" name=\"friend\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"submit\" value=\"Message user\">");
	out.println("</form>");
} else if (FriendUtils.getSentRequests(self.getName()).contains(viewing.getName())) {
	out.println("Friend request pending");
} else if (FriendUtils.getSentRequests(viewing.getName()).contains(self.getName())) {
	out.println("<form method=\"get\" action=\"Messages.jsp\">");
	out.println("<input type=\"submit\" value=\"Respond to friend request!\"");
	out.println("</form");
} else {
	out.println("<form method=\"post\" action=\"SendMessageServlet\">");
	out.println("<input type=\"hidden\" name=\"messageType\" value=\"friendRequest\">");
	out.println("<input type=\"hidden\" name=\"to\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"pageToOpen\" value=\"Profile.jsp\">");
	out.println("<input type=\"submit\" value=\"Add as friend\">");
	out.println("</form>");
}*/
%>
<%/* for (String friend : friends) {
	out.println("<form method=\"get\" action=\"Profile.jsp\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + friend + "\">");
	out.println(friend);
	out.println("<input type=\"submit\" value=\"View Profile\">");
	out.println("</form><br>");
} */%>
</td></tr>
</table>

</body>
</html>