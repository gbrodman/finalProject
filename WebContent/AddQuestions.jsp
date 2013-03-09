<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="objects.*,database.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href='http://fonts.googleapis.com/css?family=Happy+Monkey' rel='stylesheet' type='text/css'>
<link href="main.css" rel="stylesheet" type="text/css">
<title>Add Questions to Quiz</title>
</head>
<%
	User user = (User)session.getAttribute("user");
	Quiz quiz = (Quiz)session.getAttribute("currentQuiz");
	//quiz = QuizUtils.getQuizByID(quiz.getId()); //make sure most updated version of quiz. IS THIS NECESSARY?
	String title = quiz.getTitle();
	out.println("<h1>Add questions to "+title+"</h1>");
	out.println("<body>");
	out.println("<form action=\"AddQRQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Question-Response Question\">");
	out.println("</form>");
	out.println("<form action=\"AddFITBQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Fill-in-the-Blank Question\">");
	out.println("</form>");
	out.println("</form>");
	out.println("<form action=\"AddPRQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Picture-Response Question\">");
	out.println("</form>");
	out.println("<form action=\"AddMCQuestion.jsp\">");
	out.println("<br><input type=\"submit\" value=\"Add Multiple Choice Question\">");
	out.println("</form>");
	
	out.println("<br><br><form action=\"Homepage.jsp\">");
	out.println("<input type=\"submit\" value=\"Done adding questions\">");
	out.println("</form>");
	
	out.println("<h2>Current Questions:</h2>");
	List<Question> questionList = new ArrayList<Question>();
	List<Question> qrQuestions = QRQuestionUtils.getQuestionsByQuizID(quiz.getId());
	List<Question> fitbQuestions = FITBQuestionUtils.getQuestionsByQuizID(quiz.getId());
	List<Question> prQuestions = PRQuestionUtils.getQuestionsByQuizID(quiz.getId());
	List<Question> mcQuestions = MCQuestionUtils.getQuestionsByQuizID(quiz.getId());
	//eventually add all question types
	questionList.addAll(fitbQuestions);
	questionList.addAll(qrQuestions);
	questionList.addAll(prQuestions);
	questionList.addAll(mcQuestions);
	Comparator<Question> questionComparator = new Comparator<Question>() {
		public int compare(Question q1, Question q2) {
			return (q1.getOrderInQuiz()-q2.getOrderInQuiz());
		}
	};
	
	Collections.sort(questionList, questionComparator);
	out.println("<ol>");
	for (Question q : questionList) {
		out.println("<li>"+q.getQuestionTypeString()+", Points: "+q.getPointValue()+"</li>");
	}
	out.println("</ol>");
	
%>
</body>
</html>