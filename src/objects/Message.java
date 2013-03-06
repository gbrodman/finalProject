package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.UserUtils;

public class Message {
	
	private String userTo; //changed from User type
	private String userFrom; //changed from User type
	private boolean isViewed;
	private boolean isChallenge;
	private boolean isFriendRequest;
	private boolean isNote;
	
	private int quizID;
	private int bestScore;
	private String note;
	private int messageID;

	public Message(ResultSet rs) {
		if (rs != null) {
			try {
				//userTo = UserUtils.getUser(rs.getString("userTo"));
				//userFrom = UserUtils.getUser(rs.getString("userFrom"));
				userTo = rs.getString("userTo");
				userFrom = rs.getString("userFrom");
				isViewed = rs.getInt("isViewed") == 1;
				isChallenge = rs.getInt("isChallenge") == 1;
				isFriendRequest = rs.getInt("isFriendRequest") == 1;
				isNote = rs.getInt("isNote") == 1;
				quizID = rs.getInt("quizID");
				bestScore = rs.getInt("bestScore");
				note = rs.getString("note");
				messageID = rs.getInt("messageID");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public String getUserTo() {
		return userTo;
	}
	
	public String getUserFrom() {
		return userFrom;
	}
	public boolean isViewed() {
		return isViewed;
	}

	public boolean isChallenge() {
		return isChallenge;
	}

	public boolean isFriendRequest() {
		return isFriendRequest;
	}

	public boolean isNote() {
		return isNote;
	}

	public int getQuizID() {
		return quizID;
	}

	public int getBestScore() {
		return bestScore;
	}

	public String getNote() {
		return note;
	}
	
	public int getMessageID() {
		return messageID;
	}

}
