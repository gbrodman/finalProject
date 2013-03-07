<%@page import="objects.User"%>
<%@page import="database.FriendUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Message Friends</title>
</head>
<h1>Message Friends</h1><br>
<ul>
<%
User user = (User) session.getAttribute("user");
List<String> friends = FriendUtils.getFriends(user.getName());
if (friends.size() == 0) {
	out.print("<li>You have no friends :(</li>");
}
else {
	for (String friend : friends) {
		out.print("<li>");
		out.print(friend);
		out.print("<form action=\"MessageFriendServlet\" method=\"get\">");
		out.print("<input type=\"hidden\" name=\"friend\" value=\"");
		out.print(friend);
		out.print("\">");
		out.print("<input type=\"submit\" value=\"Message\" /></form></li>");
	}
}
%>
</ul>
<br><br>
<a href="Homepage.jsp">Back to homepage</a>
<body>

</body>
</html>