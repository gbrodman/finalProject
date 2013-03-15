package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class NewsFeedEntry {

	private String text;
	private Date time;
	private String user;
	private boolean isQuiz;
	private int quizID;
	
	public NewsFeedEntry(ResultSet rs) {
		try {
			text = rs.getString("text");
			time = rs.getTimestamp("time");
			user = rs.getString("user");
			isQuiz = rs.getInt("isQuiz") == 1;
			quizID = rs.getInt("quizID");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String getText() {
		return text;
	}

	public Date getTime() {
		return time;
	}
	
	public String getUser() {
		return user;
	}
	
	public boolean isQuiz() {
		return isQuiz;
	}
	
	public int quizID() {
		return quizID;
	}
}
