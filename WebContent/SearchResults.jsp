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
<% 
User user = (User)session.getAttribute("user");
out.println("<title>" + user.getName()  + "</title>");
out.println("</head>");
out.println("<div id=\"navbar\">");
out.println("<ul>");
out.println("<li><a href=\"Homepage.jsp\" class=\"topbarlinks\">Home</a></li>");
out.println("<li><a href=\"Messages.jsp\" class=\"topbarlinks\">Messages</a></li>");
out.println("<li>Create New Quiz</li>");
out.println("<li><a href=\"MessageFriends.jsp\" class=\"topbarlinks\">Friends</a></li>");
out.println("<li>Take a Quiz</li>");
out.println("</ul>");
out.println("<form method=\"post\" action=\"SearchServlet\">");
out.println("<input type=\"text\" name=\"searchtext\" value=\"Search\" id=\"searchbar\" onfocus=\"if (this.value == 'Search') {this.value = '';}\">");
out.println("</form>");
out.println("</div>");
%>
</head>
<body>
<h1>Search Results</h1>
<%User resultUser = (User) request.getAttribute("userResult");
List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizResults");
if (resultUser != null) {
	out.println("<h2>User Result:</h2>");
	out.println(resultUser.getName());%>
	<form action="Profile.jsp?" method="get">
	<input type="hidden" name="profile" value="<%out.print(resultUser.getName()); %>">
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