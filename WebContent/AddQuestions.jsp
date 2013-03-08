<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Questions to Quiz</title>
</head>
<%
	User user = (User)session.getAttribute("user");
	Quiz quiz = (Quiz)session.getAttribute("currentQuiz");
	System.out.println(quiz.getId());
	quiz = QuizUtils.getQuizByID(quiz.getId()); //make sure most updated version of quiz. IS THIS NECESSARY?
	String title = quiz.getTitle();
	out.println("<h1>Add questions to "+title+"</h1>");
	out.println("<body>");
	out.println("<form action=\"AddQRQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Question-Response Question\">");
	out.println("</form>");
	out.println("<form action=\"AddFITBQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Fill-in-the-Blank Question\">");
	out.println("</form>");
	
	out.println("<h2>Current Questions:</h2>");
	List<Question> questionList = new ArrayList<Question>();
	List<Question> qrQuestions = QRQuestionUtils.getQuestionsByQuizID(quiz.getId());
	//eventually add all question types
	questionList.addAll(qrQuestions);
	out.println("<ol>");
	for (Question q : questionList) {
		out.println("<li>"+q.getQuestionTypeString()+", Order: "+q.getOrderInQuiz()+", Points: "+q.getPointValue()+"</li>");
	}
	out.println("</ol>");
	
%>
</body>
</html>