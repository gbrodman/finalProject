<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*, database.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<% 
User user = (User)session.getAttribute("user");
out.println("<title>" + user.getName() + "'s Messages</title>");
out.println("</head>");

out.println("<body>");
List<Message> inbox = MessageUtils.getMessagesByUserTo(user.getName());
session.setAttribute("inbox", inbox);

//first display new messages:
out.println("NEW MESSAGES <br><br>");
for (int index = inbox.size() - 1; index >= 0; index--) { //display in reverse order shows newest messages first
	Message message = inbox.get(index);
	if (!message.isViewed()) {
		if (message.isChallenge()) {
			out.println("<a href=\"ViewChallenge.jsp?index="+ index + "\">CHALLENGE from " + message.getUserFrom() + "</a><br>");
			out.println("    QuizID: " + message.getQuizID() + "<br>");
			out.println("    High Score: " + message.getBestScore() + "<br>");
			String note = message.getNote();
			if (note.length() != 0) out.println("    Note: " + note + "<br>");
			out.println("<br>");
		} else if (message.isNote()) {
			out.println("<a href=\"ViewNote.jsp?index=" + index + "\">NOTE from " + message.getUserFrom() + "</a><br>");
			out.println("     Note: " + message.getNote() + "<br><br>");
		} else { // is friend request
			out.println("<a href=\"ViewFriendRequest.jsp?index=" + index + "\">FRIEND REQUEST from " + message.getUserFrom() + "</a><br>");
			String note = message.getNote();
			if (note.length() != 0) {
				out.println("     Note: " + note + "<br>");
			}
			out.println("<br>");
		}
	}
}
out.println("<br>");
//then display read messages
out.println("READ MESSAGES <br><br>");
for (int index = inbox.size() - 1; index >= 0; index--) { //display in reverse order shows newest messages first
	Message message = inbox.get(index);
	if (message.isViewed()) {
		if (message.isChallenge()) {
			out.println("<a href=\"ViewChallenge.jsp?index="+ index + "\">CHALLENGE from " + message.getUserFrom() + "</a><br>");
			out.println("    QuizID: " + message.getQuizID() + "<br>");
			out.println("    High Score: " + message.getBestScore() + "<br>");
			String note = message.getNote();
			if (note.length() != 0) out.println("    Note: " + note + "<br>");
			out.println("<br>");
		} else if (message.isNote()) {
			out.println("<a href=\"ViewNote.jsp?index=" + index + "\">NOTE from " + message.getUserFrom() + "</a><br>");
			out.println("     Note: " + message.getNote() + "<br><br>");
		} else { // is friend request
			out.println("<a href=\"ViewFriendRequest.jsp?index=" + index + "\">FRIEND REQUEST from " + message.getUserFrom() + "</a><br>");
			String note = message.getNote();
			if (note.length() != 0) {
				out.println("     Note: " + note + "<br>");
			}
			out.println("<br>");
		}
	}
}

%>

</body>
</html>