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
				timeTaken = rs.getTimestamp("timeTaken");
				timeUsed = rs.getInt("timeUsed");
				user = UserUtils.getUser(rs.getString("user"));
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


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + quizID;
		result = prime * result + score;
		result = prime * result
				+ ((timeTaken == null) ? 0 : timeTaken.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		QuizResult other = (QuizResult) obj;
		if (quizID != other.quizID)
			return false;
		if (score != other.score)
			return false;
		if (timeTaken == null) {
			if (other.timeTaken != null)
				return false;
		} else if (!timeTaken.equals(other.timeTaken))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}
}
