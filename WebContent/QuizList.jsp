<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% 
	User user = (User)session.getAttribute("user");

	List<Quiz> list = QuizUtils.getAllQuizzes();
	for (Quiz quiz : list) {
		out.print("<li>");
		out.print(quiz.getTitle());
		out.print("<form action=\"TakeQuizServlet\" method=\"post\">");
		out.print("<input type=\"hidden\" name=\"quiz\" value=\"");
		out.print(quiz.getId());
		out.print("\">");
		out.print("<input type=\"submit\" value=\"Take this Quiz!\" /></form></li>");
	}

%>



</body>
</html>