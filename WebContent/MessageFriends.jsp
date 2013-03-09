<%@page import="objects.User"%>
<%@page import="database.FriendUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Message Friends</title>
</head>
<h1>Message Friends</h1><br>
<a href="Homepage.jsp" class="backtohomepage">Back to homepage</a>
<br><br>
<div id="friendlist">
<ul>
<%
User user = (User) session.getAttribute("user");
List<String> friends = FriendUtils.getFriends(user.getName());
if (friends.size() == 0) {
	out.print("<li>You have no friends :(</li>");
}
else {
	for (String friend : friends) {
		System.out.println(user.getPhotoURL());
		out.println("<li>");
		out.print("<form action=\"MessageFriendServlet\" method=\"get\" display=\"inline\">");
		out.println("<div class=\"friendlistitem\">");
		out.println("<img src=\"" +user.getPhotoURL()+ "\" width=\"70\" height=\"70px\" >");
		out.print("<input type=\"hidden\" name=\"friend\" value=\"");
		out.print(friend);
		out.print("\">");
		out.print("<input type=\"submit\" value=\"Message\"/></form>");
		out.println("<a href=\"google.com\">" + friend + "  </a>");
		out.println("</div>");
		out.println("</li>");
	}
}
%>
</ul>
</div>
<body>

</body>
</html>