<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*, database.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey'
	rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<% 
User user = (User)session.getAttribute("user");
out.println("<title>" + user.getName()  + "</title>");
out.println("</head>");
out.println("<body>");
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

out.println("<div id=\"picturewelcome\">");
out.println("<h1> Welcome "+ user.getName()  +"</h1>");
out.println("<div class=\"profileimg\"> <img src=" +user.getPhotoURL()+" id=\"profilepicture\"></div>");//width=10% height=10% >"); 
out.println("Status: " + user.getStatus() + "<br>");
out.println("<form action=\"UpdateStatusServlet\" method=\"post\">");
out.println("<p><input type=\"text\" name=\"status\" value=\"Enter new status\" onfocus=\"if (this.value == 'Enter new status') {this.value = '';}\">");
out.println("<input type=\"submit\" value=\"Change status\">");
out.println("</form>");
out.println("</div>");

// REMOVE THIS
out.println("<a href=\"UserUtilities.jsp\">User Utilities</a>");

out.println("<h2 class=\"h2bar announcementsh2\">Announcements</h2>");
List<Announcement> announcements = AnnouncementUtils.getAnnouncements();
if (announcements.size() != 0) {
out.println("<div class=\"announcements\">");
out.println("<ul class=\"announcementsclass\">");
for (int index = announcements.size() - 1; index >= 0; index--) {
	Announcement announcement = announcements.get(index);
		out.println("<li>");
		out.println("<div class=\"announcement\">");
		out.println("<div class=\"icon\">");
		out.println("<img src=\"" + UserUtils.getUser(announcement.getCreator()).getPhotoURL() + "\">");
		out.println("</div>");
		String from = announcement.getCreator();
		System.out.println(from);
		out.println("<div class=\"announcementmessage\"><strong>  <a href=\"Profile.jsp?profile=" + from +  "\">" + from + "</a> announces:  " + announcement.getAnnouncement() + "</strong></div>");
		out.println("</div>");
		out.println("</li>");
}
out.println("</ul>");

out.println("</div>");
}



out.println("<h2 class=\"h2bar popularquizzesh2\">Popular Quizzes</h2>");
List<Quiz> pop_quizzes = QuizResultUtils.getMostPopularQuizzes(5);
out.println("<div class=\"quizlist\">");
out.println("<ul class=\"popularquizclass\">");
out.println("<li>");
out.println("<div class=\"quiz top\">");
out.println("<div class=\"name\">Title</div>");
out.println("<div class=\"createdby\">Created By</div>");
out.println("<div class=\"takequiz\">");
out.println("Take Quiz");
out.println("</div>");
out.println("<div class=\"highscore\">High Score</div>");
out.println("<div class=\"numplays\">Number of Plays</div>");
out.println("<div class=\"category\">Category</div>");
out.println("</div>");
out.println("</li>");
System.out.println(pop_quizzes.size());
for (int i = 0; i < pop_quizzes.size(); i++) {
	Quiz quiz = pop_quizzes.get(i);
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


out.println("<h2 class=\"h2bar recentquizzesh2\">Recently Taken Quizzes</h2>");
List<QuizResult> recent_quizzes = QuizResultUtils.getRecentPerformances(user.getName());
out.println("<div class=\"quizlist\" id=\"recentquizbar\">");
out.println("<ul class=\"recentquizclass\">");
if(recent_quizzes.size() == 0) {
	out.println("<li>You have not taken any quizzes recently</li>");
} else {

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
out.println("<input type=\"hidden\" name=\"username\" value=\"" + user.getName() + "\">");
out.println("<input type=\"submit\" value=\"View full personal history\">");
out.println("</form>");
}
out.println("</ul>");
out.println("</div>");


List<Quiz> recently_created_quizzes = QuizUtils.getRecentlyCreatedQuizzes(user.getName());
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
List<Achievement> achievements = AchievementUtils.getAchievementsForUser(user.getName());
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

out.println("<h2 class=\"h2bar newsfeedh2\">News Feed</h2>");
List<NewsFeedEntry> newsFeedEntries = NewsFeedUtils.getMostRecentEntries(user.getName(), 1000);
System.out.println("NUM ENTRIES: " + newsFeedEntries.size());
out.println("<div class=\"newsfeed\">");
out.println("<ul>");
for (int i = 0; i < newsFeedEntries.size(); i++) {
	NewsFeedEntry entry = newsFeedEntries.get(i);
	out.println("<li id=\"newsfeed" + (i) + "\">");
	out.println("<div class=\"newsfeedentry\">");
	String from = entry.getUser();
	String text = entry.getText();
	if (text.contains("is now friends with")) {
		System.out.println("OKAY");
		int index = text.indexOf("is now friends with");
		String to = text.substring(index + "is now friends with ".length());
		text = text.replaceFirst(to, "<a href=\"Profile.jsp?profile=" + to + "\">" + to + "</a>");
	} else if (entry.isQuiz()) {
		Quiz quiz = QuizUtils.getQuizByID(entry.quizID());
		text = text.replaceFirst(quiz.getTitle(), "<a href=\"DisplayQuiz.jsp?quiz=" + quiz.getId() + "\">" + quiz.getTitle() + "</a>");
	}
	System.out.println("FROM: " + from + " MESSAGE: " + text);
	String textToDisplay = from.equals(user.getName()) ? "You" : from;
	text = text.replace(from, "<a href=\"Profile.jsp?profile=" + from + "\">" + textToDisplay + "</a>");
	out.println("<div class=\"icon\">");
	out.println("<img src=\"" + UserUtils.getUser(from).getPhotoURL() + "\">");
	out.println("</div>");
	out.println("<div class=\"text\">");
	out.println(text);
	out.println("</div>");
	
	out.println("</div>");
	out.println("</li>");
}
out.println("</ul>");
out.println("</div>");
out.println("<div class=\"seemore\">See More...</div>");
/*if (user.isAdmin()) {
	out.println("<a href=\"AdminPage.jsp\">Go to Admin Page</a><br>");
}
out.println("<a href=\"Messages.jsp\">Go to Messages</a>");
out.println("<br><a href=\"MessageFriends.jsp\">Message Friends</a>");
out.println("<br><a href=\"CreateQuiz.jsp\">Create a Quiz</a>");
out.println("<br><a href=\"QuizList.jsp\">Take a Quiz</a>");*/
%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
	$('div').hide(1);
	$('div').show(800);
	$('.messagenotification').hide();
});

$('.popularquizzesh2').hover(function() {
	$('.popularquizclass').show(800);
	$('.recentquizclass').hide(800);
	$('.achievementsclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.announcementsclass').hide(800);
});

$('.recentquizzesh2').hover(function() {
	$('.popularquizclass').hide(800);
	$('.recentquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.announcementsclass').hide(800);
});
$('.achievementsh2').hover(function() {
	$('.achievementsclass').show(800);
	$('.popularquizclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.announcementsclass').hide(800);
});
$('.recentlycreatedquizzesh2').hover(function() {
	$('.recentlycreatedquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.popularquizclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.announcementsclass').hide(800);
});
$('.announcementsh2').hover(function() {
	$('.announcementsclass').show(800);
	$('.recentlycreatedquizclass').hide(800);
	$('.achievementsclass').hide(800);
	$('.popularquizclass').hide(800);
	$('.recentquizclass').hide(800);
});
/*$('#profilepicture').mouseenter(function() {
	$('.profileimg').animate({width:'50%', height:.5*$(window).width()}, 1500);
});*/
$('#profilepicture').click(function() {
	var width = $('.profileimg').css('width');
	if (width == '150px') {
		$('.profileimg').animate({width:'50%', height:.5*$(window).width()}, 1500);
	} else {
		$('.profileimg').animate({width:'150px', height:'150px'}, 1500);	
	}
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

$('.newsfeedh2').hover(function() {
	$('.announcementsclass').hide(400);
	$('.recentlycreatedquizclass').hide(400);
	$('.achievementsclass').hide(400);
	$('.popularquizclass').hide(400);
	$('.recentquizclass').hide(400);
	for (var i = 0; i < 2; i++) {
		$('#newsfeed' + i).show(400);
	}
});

$('.seemore').mouseenter(function() {
	var begin_index = 0;
	for (;begin_index < 20; begin_index ++) {
		if (!$('#newsfeed' + begin_index).is(":visible")) break;
	}
	for (var i = 0; i < 2; i++) {
		var index = begin_index + i;
		$('#newsfeed' + index).show(400);
	}
});



</script>
</body>
</html>