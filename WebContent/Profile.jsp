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
	out.println("<meta http-equiv=\"refresh\" content=\"0;URL=Privacy.html\">");
}
%>
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey'
	rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<%
List<Achievement> achievements = viewing.getAchievements();
List<QuizResult> recentPerformances = QuizResultUtils.getRecentPerformances(viewing.getName());
List<Quiz> ownedQuizzes = QuizUtils.getQuizzesByUser(viewing.getName());
List<String> friends = FriendUtils.getFriends(viewing.getName());%>
<title><%out.print(viewing.getName()); %>'s profile</title>
</head>
<body>
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