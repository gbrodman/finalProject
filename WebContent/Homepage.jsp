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
out.println("<div id=\"navbar\">");
out.println("<ul>");
out.println("<li><a href=\"Homepage.jsp\" class=\"topbarlinks\">Home</a></li>");
out.println("<li><a href=\"Messages.jsp\" class=\"topbarlinks\">Messages</a></li>");
out.println("<li><a href=\"CreateQuiz.jsp\" class=\"topbarlinks\">Create a Quiz</a></li>");
out.println("<li><a href=\"MessageFriends.jsp\" class=\"topbarlinks\">Friends</a></li>");
out.println("<li><a href=\"QuizList.jsp\" class=\"topbarlinks\">Take a Quiz</a></li>");
out.println("<li><a href=\"LogoutServlet\" class=\"topbarlinks\">Logout</a></li>");
out.println("</ul>");
out.println("<form method=\"post\" action=\"SearchServlet\">");
out.println("<input type=\"text\" name=\"searchtext\" value=\"Search\" id=\"searchbar\" onfocus=\"if (this.value == 'Search') {this.value = '';}\">");
out.println("</form>");
out.println("</div>");
out.println("<div id=\"picturewelcome\">");
out.println("<h1> Welcome "+ user.getName()  +"</h1>");
System.out.println(user.getPhotoURL());
out.println("<img src="+user.getPhotoURL()+" width=10% height=10% >"); 
out.println("<form action=\"UpdatePhotoServlet\" method=\"post\">");
out.println("<p><input type=\"text\" name=\"newURL\" value=\"Enter url of new photo\" onfocus=\"if (this.value == 'Enter url of new photo') {this.value = '';}\">");
out.println("<input type=\"submit\" value=\"Change photo\">");
out.println("</form>");
out.println("</div>");
out.println("<h2 class=\"h2bar\">Announcements</h2>");


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
	out.println("<strong>" + achievement.getName() + "</strong>   " + achievement.getText());
	out.println("</div>");
	out.println("</div>");
	out.println("</li>");
}
out.println("</ul>");
out.println("</div>");


out.println("<h2 class=\"h2bar\">New Messages</h2>");
out.println("<br>");
;
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
	//$('.recentquizclass').show(1000);
});

$('.popularquizzesh2').hover(function() {
	$('.popularquizclass').show(800);
	$('.recentquizclass').hide(800);
	$('.achievementsclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
});

$('.recentquizzesh2').hover(function() {
	$('.popularquizclass').hide(800);
	$('.recentquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
});
$('.achievementsh2').hover(function() {
	$('.achievementsclass').show(800);
	$('.popularquizclass').hide(800);
	$('.recentquizclass').hide(800);
	$('.recentlycreatedquizclass').hide(800);
});
$('.recentlycreatedquizzesh2').hover(function() {
	$('.recentlycreatedquizclass').show(800);
	$('.achievementsclass').hide(800);
	$('.popularquizclass').hide(800);
	$('.recentquizclass').hide(800);
});




</script>
</body>
</html>