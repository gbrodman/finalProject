package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

public class FITBQuestion implements Question{
	
	private String answer;
	private String stringDisplay;
	private int pointValue;
	private int quizID;
	private String body;
	private int order;
	
	private String getStringDisplay() {
		String inst = "<h1>Fill-in-the-Blank Question</h1><br> Enter the correct word to complete the sentence in the text area below. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans = "<br><br><form action=\"SubmitAnswerServlet\" method=\"post\">Enter word to fill in the blank: <input name=\"answer\">";
		String submit = "<br><input type=\"submit\" value=\"Submit answer\"></form>";
		return (inst+pnts+text+ans+submit);
	}
	
	public FITBQuestion(String body, String answer, int points, int quizID, int order) {
		this.quizID = quizID;
		this.pointValue = points;
		this.answer = answer;
		this.body = body;
		this.stringDisplay = getStringDisplay();
		this.order = order;
	}
	
	public FITBQuestion(ResultSet rs) {
		if (rs != null) {
			try {
				this.quizID = rs.getInt("quizID");
				this.body = rs.getString("body");
				this.answer = rs.getString("answer");
				this.pointValue = rs.getInt("points");
				this.stringDisplay = getStringDisplay();
				this.order = rs.getInt("orderInQuiz");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean isCorrect(String answer) {
		return answer.equals(this.answer);
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
		return 2;
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
		return "Fill-in-the-Blank";
	}
}
