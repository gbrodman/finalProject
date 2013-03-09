package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MCQuestion implements Question{

	private String answer;
	private String stringDisplay;
	private int pointValue;
	private int quizID;
	private String body;
	private int order;
	String choices;
	
	private String getStringDisplay() {
		String inst = "<h1>Multiple Choice Question</h1><br> Please select a single answer from provided choices. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans = "<br><br><form action=\"SubmitAnswerServlet\" method=\"post\">";
		int end = 0;
		int start = 0;
		while (true) {
			start = choices.indexOf('[',end);
			if (start == -1) break;
			end = choices.indexOf(']',start+1);
			if (end == -1) break;
			String choice = choices.substring(start+1,end);
			ans += "<input type=\"radio\" name=\"answer\" value=\""+choice+"\"> "+choice+"<br>";
		}
		String submit = "<br><input type=\"submit\" value=\"Submit answer\"></form>";
		return (inst+pnts+text+ans+submit);
	}
	
	public MCQuestion(String body, String answer, String answerChoices, int points, int quizID, int order) {
		this.quizID = quizID;
		this.pointValue = points;
		this.answer = answer;
		this.body = body;
		this.order = order;
		this.choices = answerChoices;
		this.stringDisplay = getStringDisplay();
	}
	
	public MCQuestion(ResultSet rs) {
		if (rs != null) {
			try {
				this.quizID = rs.getInt("quizID");
				this.body = rs.getString("body");
				this.answer = rs.getString("answer");
				this.pointValue = rs.getInt("points");
				this.order = rs.getInt("orderInQuiz");
				this.choices = rs.getString("answerChoices");
				this.stringDisplay = getStringDisplay();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean isCorrect(String answer) {
		return answer.equals(this.answer);
	}
	
	public String getAnswerChoices() {
		return choices;
	}
	
	public int getQuizID() {
		return quizID;
	}
	public int numAnswers() {
		return 1;
	}
	
	public String getAnswers() {
		return answer;
	}
	
	public int getQuestionType() {
		return 3;
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
		return "Multiple Choice";
	}
	
}
