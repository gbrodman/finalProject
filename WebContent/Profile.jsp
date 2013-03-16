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
List<QuizResult> recent_quizzes = QuizResultUtils.getRecentPerformances(viewing.getName());
List<Quiz> recently_created_quizzes = QuizUtils.getQuizzesByUser(viewing.getName(), self);%>
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
	$('.aboutmeclass').hide();
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
	out.println("<form method=\"post\" action=\"Messages.jsp\">");
	out.println("<input type=\"submit\" value=\"Respond to friend request!\">");
	out.println("</form>");
} else if (FriendUtils.getFriends(self.getName()).contains(viewing.getName())) {
	out.println("<span class=\"alreadyfriends\">Friends!</span>");	
} else {
	out.println("<form method=\"post\" action=\"SendMessageServlet\">");
	out.println("<input type=\"hidden\" name=\"messageType\" value=\"friendRequest\">");
	out.println("<input type=\"hidden\" name=\"to\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + viewing.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"pageToOpen\" value=\"Profile.jsp?profile=" + viewing.getName() + "\">");
	out.println("<input type=\"submit\" value=\"Add as friend\">");
	out.println("</form>");
}
out.println("</div>");
out.println("<div class=\"messagebutton\">");
out.print("<form action=\"MessageFriendServlet\" method=\"get\" display=\"inline\">");
out.print("<input type=\"hidden\" name=\"friend\" value=\"");
out.print(viewing.getName());
out.print("\">");
out.print("<input type=\"submit\" value=\"Message\"/></form>");
out.println("</div>");
out.println("</div>");
out.println("<div class=\"statusarea\">");
out.println("<strong>How I am Feeling Today:</strong>");
out.println("<em>" + viewing.getStatus() + "</em>");
out.println("</div>");
out.println("</div>");

out.println("");

out.println("<h2 class=\"h2bar aboutmeh2\">About Me</h2>");

out.println("<div class=\"aboutmeclass\">");
out.println("<strong>About me:</strong><br><span style=\"margin-left:15px;\"><em>" + viewing.getAboutMe() + "</em></span>");

out.println("</div>");

out.println("<h2 class=\"h2bar friendsh2\">Friends</h2>");

out.println("<div id=\"friendlist\">");
out.println("<ul class=\"friendsclass\">");

List<String> friends = FriendUtils.getFriends(viewing.getName());
if (friends.size() == 0) {
	out.print("<li>You have no friends :(</li>");
}
else {
	for (String friend : friends) {
		System.out.println(user.getPhotoURL());
		User friend_user = UserUtils.getUser(friend);
		out.println("<li>");
		out.print("<form action=\"MessageFriendServlet\" method=\"get\" display=\"inline\">");
		out.println("<div class=\"friendlistitem\">");
		out.println("<img src=\"" +friend_user.getPhotoURL()+ "\" width=\"70\" height=\"70px\" >");
		out.print("<input type=\"hidden\" name=\"friend\" value=\"");
		out.print(friend);
		out.print("\">");
		out.print("<input type=\"submit\" value=\"Message\"/></form>");
		out.println("<a href=\"Profile.jsp?profile=" + friend + "\">" + friend + "</a>");
		out.println("</div>");
		out.println("</li>");
	}
}

out.println("</ul>");
out.println("</div>");


out.println("<h2 class=\"h2bar recentquizzesh2\">Recently Taken Quizzes</h2>");
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
System.out.println(recent_quizzes.size());
for (int i = 0; i < recent_quizzes.size(); i++) {
	QuizResult result = recent_quizzes.get(i);
	Quiz quiz = QuizUtils.getQuizByID(result.getQuizID());
	out.println("<li>");
	out.println("<div class=\"quiz\">");
	out.println("<div class=\"name\">");
	out.println(quiz.getTitle());
	out.println("</div>");
	out.println("<div class=\"createdby\">");
	out.println("<a href=\"Profile.jsp?profile=" + quiz.getOwner().getName() + "\" class=\"topbarlinks\">" + quiz.getOwner().getName() + "</a>");
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
out.println("<form action=\"UserHistory.jsp\">");
out.println("<input type=\"hidden\" name=\"username\" value=\"" + viewing.getName() + "\">");
out.println("<input type=\"submit\" value=\"View full personal history\">");
out.println("</form>");
out.println("</ul>");
out.println("</div>");


System.out.println(recently_created_quizzes.size());
if (recently_created_quizzes.size() > 0) {
out.println("<h2 class=\"h2bar recentlycreatedquizzesh2\">Recently Created Quizzes</h2>");
out.println("<div class=\"quizlist \">");
out.println("<ul class=\"recentlycreatedquizclass\">");
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
System.out.println(recently_created_quizzes.size());
for (int i = 0; i < recently_created_quizzes.size(); i++) {
	Quiz quiz = recently_created_quizzes.get(i);
	out.println("<li>");
	out.println("<div class=\"quiz\">");
	out.println("<div class=\"name\">");
	out.println(quiz.getTitle());
	out.println("</div>");
	out.println("<div class=\"createdby\">");
	out.println("<a href=\"Profile.jsp?profile=" + quiz.getOwner().getName() + "\" class=\"topbarlinks\">" + quiz.getOwner().getName() + "</a>");
	out.println("</div>");
	out.println("<div class=\"takequiz\">");
	out.print("<form action=\"DisplayQuizServlet\" method=\"post\">");
	out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
	out.print(quiz.getId());
	out.print("\">");
	out.print("<input type=\"image\" src=\"QuizMePictures/QuizMe.png\"/></form>");
	out.println("</div>");
	out.println("<div class=\"highscore\">");
	List<QuizResult> highscores = QuizResultUtils.getTopPerformances(quiz.getId(), 1);
	int high_score = (highscores.size() == 1) ? highscores.get(0).getScore() : 0;
	out.println(high_score);
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
out.println("</div>");
}

out.println("<h2 class=\"h2bar achievementsh2\">Achievements</h2>");
List<Achievement> achievements = AchievementUtils.getAchievementsForUser(viewing.getName());
out.println("<div class=\"achievements\">");
out.println("<ul class=\"achievementsclass\">");
for (int i = 0; i < achievements.size(); i++) {
	Achievement achievement = achievements.get(i);
	out.println("<li>");
	out.println("<div class=\"achievement\">");
	out.println("<div class=\"icon\">");
	out.println("<img src=\"" + achievement.getPhotoURL() + "\">");
	out.println("</div>");
	out.println("<div class=\"blankright\">  </div>");
	out.println("<div class=\"achievementtext\">");
	out.println("<strong>" + achievement.getName() + ": </strong>   " + achievement.getText());
	out.println("</div>");
	out.println("</div>");
	out.println("</li>");
}
out.println("</ul>");
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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$('.recentquizzesh2').hover(function() {
	$('.recentquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.friendsclass').hide(800);
	$('.aboutmeclass').hide(800);
});
$('.achievementsh2').hover(function() {
	$('.achievementsclass').show(800);
	$('.recentquizclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.friendsclass').hide(800);
	$('.aboutmeclass').hide(800);
});
$('.recentlycreatedquizzesh2').hover(function() {
	$('.recentlycreatedquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.friendsclass').hide(800);
	$('.aboutmeclass').hide(800);
});
$('.aboutmeh2').hover(function() {
	$('.recentlycreatedquizclass').hide(800);
	$('.achievementsclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.friendsclass').hide(800);
	$('.aboutmeclass').show(800);
});
$('.friendsh2').hover(function() {
	$('.recentlycreatedquizclass').hide(800);
	$('.achievementsclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.friendsclass').show(800);
	$('.aboutmeclass').hide(800);
});
</script>
</td></tr>
</table>

</body>
</html>