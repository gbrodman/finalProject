package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import database.UserUtils;

public class QuizResult {

	private int quizID;
	private int score;
	private User user;
	
	private Date timeTaken;
	private long timeUsed;
	
	public QuizResult(ResultSet rs) {
		if (rs != null) {
			try {
				quizID = rs.getInt("quizID");
				score = rs.getInt("score");
				user = UserUtils.getUser(rs.getString("user"));
				timeTaken = rs.getTimestamp("timeTaken");
				timeUsed = rs.getInt("timeUsed");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public QuizResult() {
		this(null);
	}
	
	public int getQuizID() {
		return quizID;
	}

	public int getScore() {
		return score;
	}

	public User getUser() {
		return user;
	}

	public Date getTimeTaken() {
		return timeTaken;
	}

	public long getTimeUsed() {
		return timeUsed;
	}

}
