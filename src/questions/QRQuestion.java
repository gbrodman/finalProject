package questions;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import database.QuizUtils;
import database.UserUtils;

public class QRQuestion implements Question{
	
	private List<String> answers;
	private String ansString;
	private String stringDisplay;
	private String instantQuestion;
	private int pointValue;
	private int quizID;
	private String body;
	private int order;
	
	private String getStringDisplay() {
		String inst = "<h1>Question-Response Question</h1><br> Please enter a single answer in provided text area. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans = "<br><br><form action=\"SubmitAnswerServlet\" method=\"post\">Enter answer to question: <input name=\"answer\">";
		String submit = "<br><input type=\"submit\" value=\"Submit answer\"></form>";
		return (inst+pnts+text+ans+submit);
	}
	
	public String getInstantCorrectResult(String ans) {
		String inst = "<h1>Question-Response Question</h1><br> Please enter a single answer in provided text area. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans1 = "<br><br>Your answer was: "+ans;
		String res;
		if (isCorrect(ans)) res = "<br>Congratulations, your answer was correct!";
		else {
			res = "<br>Sorry, your answer was incorrect. Better luck next time!";
			res += "<br>Possible correct answers are: <ul>";
			for (String str : answers) {
				res += "<li>"+ str + "</li>";
			}
			res += "</ul>";
			
		}
		String next = "<br><br><form action=\"ViewQuestion.jsp\">";
		String submit = "<br><input type=\"submit\" value=\"Next Question\"></form>";
		return (inst+pnts+text+ans1+res+next+submit);
	}
	
	private String getInstantCorrectQuestion() {
		String inst = "<h1>Question-Response Question</h1><br> Please enter a single answer in provided text area. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans = "<br><br><form action=\"InstantCorrectAnswerServlet\" method=\"post\">Enter answer to question: <input name=\"answer\">";
		String submit = "<br><input type=\"submit\" value=\"Submit answer\"></form>";
		return (inst+pnts+text+ans+submit);
	}
	
	private void parseAnswer(String answer) {
		int end = 0;
		int start = 0;
		while (true) {
			start = answer.indexOf('[',end);
			if (start == -1) break;
			end = answer.indexOf(']',start+1);
			if (end == -1) break;
			String ans = answer.substring(start+1,end);
			this.answers.add(ans);
			start = end;
		}
	}
	
	public QRQuestion(String body, String answer, int points, int quizID, int order) {
		this.quizID = quizID;
		this.pointValue = points;
		this.ansString = answer;
		this.answers = new ArrayList<String>();
		parseAnswer(answer);
		this.body = body;
		this.stringDisplay = getStringDisplay();
		this.instantQuestion = getInstantCorrectQuestion();
		this.order = order;
	}
	
	public QRQuestion(ResultSet rs) {
		if (rs != null) {
			try {
				this.quizID = rs.getInt("quizID");
				this.body = rs.getString("body");
				this.ansString = rs.getString("answer");
				this.answers = new ArrayList<String>();
				parseAnswer(ansString);
				this.pointValue = rs.getInt("points");
				this.stringDisplay = getStringDisplay();
				this.instantQuestion = getInstantCorrectQuestion();
				this.order = rs.getInt("orderInQuiz");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public String getAnswerChoices() {
		return "";
	}
	
	public String getURL() {
		return "";
	}
	
	public String getInstantQuestion() {
		return instantQuestion;
	}
	
	public boolean isCorrect(String answer) {
		for (String a : answers) {
			if (a.equals(answer)) return true;
		}
		return false;
	}
	
	public int getQuizID() {
		return quizID;
	}
	
	public int numAnswers() {
		return 1;
	}
	
	public String getAnswers() {
		return ansString;
	}
	
	public int getQuestionType() {
		return 1;
	}
	
	public String getQuestionDisplay() {
		return stringDisplay;
	}
	
	public int getPointValue() {
		return pointValue;
	}
	
	public String getBody() {
		return body;
	}
	
	public int getOrderInQuiz() {
		return order;
	}
	
	public String getQuestionTypeString() {
		return "Question-Response";
	}
	
}
