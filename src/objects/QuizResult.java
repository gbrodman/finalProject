package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import database.FriendUtils;
import database.UserUtils;

public class QuizResult {

	
	private static final long MILI_IN_SEC = 1000;
	private static final long SEC_IN_MIN = 60;
	
	private int quizID;
	private int score;
	private String user;
	
	private Date timeTaken;
	private long timeUsed;
	private String timeUsedString;
	
	public QuizResult(ResultSet rs) {
		if (rs != null) {
			try {
				quizID = rs.getInt("quizID");
				score = rs.getInt("score");
				timeTaken = rs.getTimestamp("timeTaken");
				timeUsed = rs.getInt("timeUsed");
				user = rs.getString("user");
				timeUsedString = timeUsedToString();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String timeUsedToString(long time) {
		String result;
		if (time < 1000) result = time + " ms";
	    else if (time < 60000) {
	    	long remainder = time%MILI_IN_SEC;
	    	result = time/MILI_IN_SEC + " sec " + remainder + " ms";
	    }else {
	    	long secs = time/MILI_IN_SEC;
	    	long remainder = secs%SEC_IN_MIN;
	    	result = secs/SEC_IN_MIN + " min " + remainder + " sec";
	    }
		return result;
	}
	
	private String timeUsedToString() {
		String result;
		if (timeUsed < 1000) result = timeUsed + " ms";
	    else if (timeUsed < 60000) {
	    	long remainder = timeUsed%MILI_IN_SEC;
	    	result = timeUsed/MILI_IN_SEC + " sec " + remainder + " ms";
	    }else {
	    	long secs = timeUsed/MILI_IN_SEC;
	    	long remainder = secs%SEC_IN_MIN;
	    	result = secs/SEC_IN_MIN + " min " + remainder + " sec";
	    }
		return result;
	}

	public String getTimeUsedString() {
		return timeUsedString;
	}
	
	public String getUser(User current) {
		if (UserUtils.getUser(user).getPrivacyLevel() == 0 || FriendUtils.areFriends(current.getName(), user)) {
			return user;
		} else {
			return "Anonymous";
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

	public Date getTimeTaken() {
		return timeTaken;
	}

	public long getTimeUsed() {
		return timeUsed;
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
