package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.MessageUtils;

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

	
	// For initializing new messages from the UI
	public Message(String userTo, String userFrom, boolean isChallenge, boolean isFriendRequest, boolean isNote, int quizID, int bestScore, String note) {
		this.userTo = userTo;
		this.userFrom = userFrom;
		this.isViewed = false;
		this.isChallenge = isChallenge;
		this.isFriendRequest = isFriendRequest;
		this.isNote = isNote;
		this.quizID = quizID;
		this.bestScore = bestScore;
		this.note = note;
		this.messageID = MessageUtils.getNewId();
	}

	public Message(ResultSet rs) {
		if (rs != null) {
			try {
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
