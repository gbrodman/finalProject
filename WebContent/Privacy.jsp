<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="database.FriendUtils"%>
<%@page import="database.UserUtils"%>
<%@page import="objects.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Access Denied</title>
</head>
<body>
You must be friends with this person to view their profile.<br>
<%
User otherUser = UserUtils.getUser(request.getParameter("otherUser"));
User self = (User) session.getAttribute("user");
if (FriendUtils.getSentRequests(self.getName()).contains(otherUser.getName())) {
	out.println("Friend request pending");
} else if (FriendUtils.getSentRequests(otherUser.getName()).contains(self.getName())) {
	out.println("<form method=\"get\" action=\"Messages.jsp\">");
	out.println("<input type=\"submit\" value=\"Respond to friend request!\"");
	out.println("</form");
} else {
	out.println("<form method=\"post\" action=\"SendMessageServlet\">");
	out.println("<input type=\"hidden\" name=\"messageType\" value=\"friendRequest\">");
	out.println("<input type=\"hidden\" name=\"to\" value=\"" + otherUser.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"profile\" value=\"" + otherUser.getName() + "\">");
	out.println("<input type=\"hidden\" name=\"pageToOpen\" value=\"Privacy.jsp\">");
	out.println("<input type=\"hidden\" name=\"otherUser\" value=\"" + otherUser.getName() + "\">");
	out.println("<input type=\"submit\" value=\"Add as friend\">");
	out.println("</form>");
}%>
<form action="Homepage.jsp">
<input type="submit" value="Return to homepage">
</form>
</body>
</html>