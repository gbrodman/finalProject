package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PRQuestion implements Question{
	
	private String answer;
	private String stringDisplay;
	private int pointValue;
	private int quizID;
	private String body;
	private int order;
	String photoURL;
	
	private String getStringDisplay() {
		String inst = "<h1>Picture-Response Question</h1><br> Please enter a single answer in provided text area. ";
		String pnts = "This question is worth "+pointValue+" points.";
		String text = "<br><br>"+body;
		String ans = "<br><br><form action=\"SubmitAnswerServlet\" method=\"post\">Enter answer to question: <input name=\"answer\">";
		String submit = "<br><input type=\"submit\" value=\"Submit answer\"></form>";
		return (inst+pnts+text+ans+submit);
	}
	
	public PRQuestion(String body, String answer, String url, int points, int quizID, int order) {
		this.quizID = quizID;
		this.pointValue = points;
		this.answer = answer;
		this.body = body;
		this.stringDisplay = getStringDisplay();
		this.order = order;
		this.photoURL = url;
	}
	
	public PRQuestion(ResultSet rs) {
		if (rs != null) {
			try {
				this.quizID = rs.getInt("quizID");
				this.body = rs.getString("body");
				this.answer = rs.getString("answer");
				this.pointValue = rs.getInt("points");
				this.stringDisplay = getStringDisplay();
				this.order = rs.getInt("orderInQuiz");
				this.photoURL = rs.getString("photoURL");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public String getPhotoURL() {
		return photoURL;
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
		return 4;
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
		return "Picture-Response";
	}
}
