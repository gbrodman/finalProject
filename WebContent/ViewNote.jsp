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
int index = Integer.parseInt(request.getParameter("index"));
List<Message> inbox = (List<Message>)session.getAttribute("inbox");
Message message = inbox.get(index);
MessageUtils.markAsRead(message);
session.setAttribute("currentMessage",message);
out.println("<title>Note from " + message.getUserFrom() + "</title>");
out.println("</head>");
out.println("<body>");
out.println("<h3>");
out.println(message.getUserFrom() + " sent you a note.");
out.println("</h3>");
out.println("<p>");
String note = message.getNote();
out.println(note + "<br>");

out.println("<form name = 'form3' action=\"DeleteMessageServlet\" method=\"post\">");
out.println("<input type=\"submit\" value=\"Delete Message\">");
out.println("</form>");

out.println("<form name = 'form2' action=\"Messages.jsp\">");
out.println("<input type=\"submit\" value=\"Go back to messages.\">");
out.println("</form");

out.println("</body>");

%>
</html>