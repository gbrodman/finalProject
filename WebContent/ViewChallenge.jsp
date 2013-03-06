<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="objects.*, database.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% 
int index = Integer.parseInt(request.getParameter("index"));
List<Message> inbox = (List<Message>)session.getAttribute("inbox");
Message message = inbox.get(index);
MessageUtils.markAsRead(message);
out.println("<title>Challenge from " + message.getUserFrom() + "</title>");
out.println("</head>");
out.println("<body>");
out.println("<h3>");
out.println(message.getUserFrom() + " challenged you take a quiz.");
out.println("</h3>");
out.println("<p>");
String note = message.getNote();
if (note.length() != 0) out.println(note + "<br>");
out.println(message.getUserFrom() + "'s High Score: " + message.getBestScore());
out.println("TODO: quizid: " + message.getQuizID());

out.println("</body>");

%>
</html>