<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>New Message</title>
</head>
<body>
<h1>Send New Message</h1><br>
To:  <span id="messagefriendname" ><%out.print(request.getParameter("friend")); %></span><br><br>
Message: <br>
<form action="SendMessageServlet" method="post">
<textarea name="text" cols="40" rows="10" name="text" onfocus="if (this.value == 'Put your message here.') {this.value = ''}">
Put your message here.</textarea><br>
<input type="submit" value="Submit" />
<input type="hidden" name="messageType" value="note"/>
<input type="hidden" name="friend" value="<%out.println(request.getParameter("friend"));%>" />
</form>
</body>
</html>