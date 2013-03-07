<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Message</title>
</head>
<body>
<h1>Send New Message</h1><br>
To: <%out.print(request.getParameter("friend")); %><br>
Message: <br>
<form action="SendMessageServlet" method="post">
<textarea name="text" cols="40" rows="10" name="text">
Put your message here.</textarea><br>
<input type="submit" value="Submit" />
<input type="hidden" name="friend" value="<%out.println(request.getParameter("friend"));%>" />
</form>
</body>
</html>