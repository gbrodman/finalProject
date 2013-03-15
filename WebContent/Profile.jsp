<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*,database.*,java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey'
	rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<%User viewing = UserUtils.getUser(request.getParameter("profile")); 
User self = (User) session.getAttribute("user");
List<Achievement> achievements = viewing.getAchievements();
List<QuizResult> recentPerformances = QuizResultUtils.getRecentPerformances(viewing.getName());
List<Quiz> ownedQuizzes = QuizUtils.getQuizzesByUser(viewing.getName());
List<String> friends = FriendUtils.getFriends(viewing.getName());%>
<title><%out.print(viewing.getName()); %>'s profile</title>
</head>
<body>
<h1><%out.print(viewing.getName()); %></h1>
<table cellspacing="0" WIDTH="100%" >
<col width="33%">
<col width="33%">
<col width="33%">
<tr>
<td  ALIGN="left">
<img src="<%out.print(viewing.getPhotoURL());%>"  ></img>
</td><td  ALIGN="left">
<% if (FriendUtils.getFriends(self.getName()).contains(viewing.getName())) {
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
	out.println("<input type=\"submit\" value=\"Add as friend\"");
	out.println("</form>");
}
%>
</td><td>
Friends: <br><br>
<% for (String friend : friends) {
	out.println("<form method=\"get\" action=\"Profile.jsp\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + friend + "\">");
	out.println(friend);
	out.println("<input type=\"submit\" value=\"View Profile\">");
	out.println("</form><br>");
} %>
</td></tr>
</table>

</body>
</html>