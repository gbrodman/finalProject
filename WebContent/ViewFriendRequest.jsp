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
session.setAttribute("currentMessage", message);
MessageUtils.markAsRead(message);
out.println("<title>Friend Request from " + message.getUserFrom() + "</title>");
out.println("</head>");
out.println("<body>");
out.println("<h3>");
out.println(message.getUserFrom() + " wants to be friends!");
out.println("</h3>");
out.println("<p>");
String note = message.getNote();
if (note.length() != 0) out.println(note + "<br>");
out.println("<form name='form1' action=\"HandleFriendRequestsServlet\" method=\"post\">");
out.println("<input type=\"hidden\" id=\"status\">");
out.println("<input type=\"button\" value=\"Accept\" onclick=\"accept()\">");
out.println("<input type=\"button\" value=\"Reject\" onclick=\"reject()\">");
out.println("</form>");
out.println("</body>");
%>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function accept() {
	$('#status').val("accept");
	form1.submit();
}
function reject() {
	$('#status').val("reject");	
	form1.submit();
}

</script>
</html>