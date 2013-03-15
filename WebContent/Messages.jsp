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

out.println("<div class=\"messagetitles\" <h2>MESSAGES</h2></div>");
out.println("<div id=\"inbox\">");
out.println("<ul>");
System.out.println(inbox.size());
out.println("<li>");
out.println("<div class=\"inboxmessage top\">");
out.println("<div class=\"icon\"><img src=\"http://img6.imageshack.us/img6/4351/white3.jpg\"></div>");
out.println("<div class=\"icon\"><img src=\"http://img6.imageshack.us/img6/4351/white3.jpg\"></div>");
out.println("<div class=\"icon righticon\"><img src=\"http://img6.imageshack.us/img6/4351/white3.jpg\"></div>");
out.println("<div class=\"icon righticon\"><img src=\"http://img6.imageshack.us/img6/4351/white3.jpg\"></div>");
out.println("<div class=\"fromtomessage\">From</div>");
out.println("<div class=\"fromtomessage\">To</div>");
out.println("<div class=\"messagemessage\">Message</div>");
out.println("</div></li>");
for (int index = inbox.size() - 1; index >= 0; index--) { //display in reverse order shows newest messages first
	Message message = inbox.get(index);
	if (!message.isFriendRequest()) {
		System.out.println(message.getNote());
		out.println("<li>");
		out.println("<div class=\"inboxmessage\">");
		if (!message.isViewed()) {
			System.out.println("not viewed");
			out.println("<div class=\"newinboxmessage\">");
		} else {
			System.out.println("viewed");
			out.println("<div class=\"readinboxmessage\">");
		}
		out.println("<div class=\"icon lefticon\">");
		if (message.isChallenge()) {// http://s176520660.online.de/dungeonslayers/forum/index.php?action=dlattach;attach=3848;type=avatar
			out.println("<img src=\"QuizMePictures/Untitled.png\">"); // 
		} else {
			out.println("<img src=\"http://www.clker.com/cliparts/s/V/x/x/P/H/mail-message-new-md.png\">");
		}
		out.println("</div>");
		out.println("<div class=\"icon lefticon\">");
		out.println("<img src=\"" + UserUtils.getUser(message.getUserFrom()).getPhotoURL() + "\">"); // + "\" width=\"48\" height=\"48\">");
		out.println("</div>");
		out.println("<div class=\"icon righticon\">");
		if (message.isChallenge()) {
			out.println("<a href=\"ViewChallenge.jsp?index="+ index + "\">");
		} else {
			out.println("<a href=\"ViewNote.jsp?index=" + index + "\">");
		}
		out.println("<img src=\"http://icons.iconarchive.com/icons/custom-icon-design/pretty-office-2/256/message-already-read-icon.png\""  +">"); // width=\"48\" height=\"48\">");
		out.println("</a>");
		out.println("</div>");
		out.println("<div class=\"icon righticon\" id=\"deletebutton\">");
		out.println("<form name = 'form3' action=\"DeleteMessageServlet\" method=\"post\" onsubmit=\"return confirm('Do you really want to delete this message')\">");
		out.println("<input name=\"messageid\" type=\"hidden\" id=\"messageid\" value=\"" + message.getMessageID() + "\">");
		out.println("<input type=\"image\" src=\"http://www.veryicon.com/icon/png/System/Must%20Have/Delete.png\">");
		out.println("</form>");

		//out.println("<img src=\"http://www.veryicon.com/icon/png/System/Must%20Have/Delete.png\""  +">"); // width=\"48\" height=\"48\">");
		out.println("</div>");
		out.println("<div class=\"fromtomessage\">");
		out.println("<a href=\"Profile.jsp?profile=" + message.getUserFrom() + "\" class=\"topbarlinks\">" + message.getUserFrom() + "</a>");
		out.println("</div>");
		out.println("<div class=\"fromtomessage\">");
		out.println("<a href=\"Profile.jsp?profile=" + message.getUserTo() + "\" class=\"topbarlinks\">" + message.getUserTo() + "</a>");
		out.println("</div>");
		out.println("<div class=\"messagemessage\">");
		if (message.isChallenge()) {
			out.println(message.getUserFrom() + " challenged you to take a quiz!");
		} else if (message.isNote()) {
			out.println(message.getNote());
		}
		out.println("</div>");
		out.println("</div>");
		out.println("</li>");
	}
}
out.println("</ul>");
out.println("</div>");
out.println("<br>");

out.println("<div class=\"messagetitles\" <h2>FRIEND REQUESTS</h2></div>");
//out.println("<div class=\"bigblog\"></div>");
out.println("<div id=\"friendrequests\">");
out.println("<ul>");
for (int index = inbox.size() - 1; index >= 0; index--) {
	Message message = inbox.get(index);
	if (message.isFriendRequest()) {
		out.println("<li>");
		out.println("<div class=\"friendrequest\">");
		out.println("<div class=\"icon\">");
		out.println("<img src=\"" + UserUtils.getUser(message.getUserFrom()).getPhotoURL() + "\">");
		out.println("</div>");
		String from = message.getUserFrom();
		System.out.println(from);
		out.println("<div class=\"friendrequestmessage\">  " + from + " wants to be your friend!</div>");
		out.println("<form name='form1' action=\"HandleFriendRequestServlet\" method=\"post\">");
		out.println("<input type=\"hidden\" name=\"status\">");
		out.println("<input type=\"hidden\" name=\"messageID\" value=\"" + message.getMessageID() + "\">");
		out.println("<div class=\"acceptreject\">");
		out.println("<input type=\"button\" value=\"Accept\" onclick=\"acceptFriend()\">");
		out.println("</div>");
		out.println("<div class=\"acceptreject\">");
		out.println("<input type=\"button\" value=\"Reject\" onclick=\"rejectFriend()\">");
		out.println("</div>");
		out.println("</form>");
		out.println("</div>");
		out.println("</li>");
	}
}
out.println("</ul>");
out.println("</div>");
out.println("</body>");
%>



<script language="JavaScript">
	function acceptFriend() {
		document.form1.status.value = "accept";
		alert("accept");
		form1.submit();
	} 
	
	function rejectFriend() {
		document.form1.status.value = "reject";
		alert("reject");
		form1.submit();
	}
	
</script>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function() {
	$(".inboxmessage").show(600);
	//$(".bigblog").show(600);
});
</script>
</body>
</html>