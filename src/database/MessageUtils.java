package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.Message;

public class MessageUtils {

	public static List<Message> getMessagesByUserTo(String username) {
		List<Message> result = new ArrayList<Message>();
		String query = "SELECT * FROM messages WHERE userTo=\"" + username + "\";";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				Message message = new Message(rs);
				result.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	

	public static void markAsRead(Message message) { //should be messageID field in case identical messages are sent?
		if (message.isViewed()) return;
		String update= "UPDATE messages SET isViewed=1 WHERE messageID = " + message.getMessageID() + ";";
		MyDB.updateDatabase(update);
	}
	
	public static void removeMessage(Message message) {
		String update = "DELETE FROM messages WHERE messageID = " + message.getMessageID() + ";";
		MyDB.updateDatabase(update);
	}

		
	public static void sendFriendRequest(String userTo, String userFrom) {
		Message message = new Message(userTo, userFrom, false, true, false, -1, -1, userTo + " wants to be friends with you!");
		sendMessage(message);
	}
	
	public static void sendNote(String userTo, String userFrom, String note) {
		Message message = new Message(userTo, userFrom, false, false, true, -1, -1, note);
		sendMessage(message);
	}
	
	public static void sendChallenge(String userTo, String userFrom, int quizID) {
		int bestScore = QuizResultUtils.getBestScore(userTo, quizID);
		String note = userTo + " has challenged you to a quiz! Their best score was " + bestScore + "%. Click on the link to try to beat it.";
		Message message = new Message(userTo, userFrom, true, false, false, quizID, bestScore, note);
		sendMessage(message);
	}
	
	public static int getNewId() {
		String query = "SELECT messageID FROM messages ORDER BY messageID DESC;";
		ResultSet rs = MyDB.queryDatabase(query);
		if (MyDB.resultIsEmpty(rs)) return 0;
		try {
			rs.next();
			int lastId = rs.getInt("messageID");
			return lastId + 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static void sendMessage(Message message) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO messages VALUES(\"");
		update.append(message.getUserTo());
		update.append("\",\"");
		update.append(message.getUserFrom());
		update.append("\",");
		update.append(message.isViewed() ? 1 : 0);
		update.append(",");
		update.append(message.isChallenge() ? 1 : 0);
		update.append(",");
		update.append(message.isFriendRequest() ? 1 : 0);
		update.append(",");
		update.append(message.isNote() ? 1 : 0);
		update.append(",");
		update.append(message.getQuizID());
		update.append(",");
		update.append(message.getBestScore());
		update.append(",\"");
		update.append(message.getNote());
		update.append("\",");
		update.append(message.getMessageID());
		update.append(");");
		MyDB.updateDatabase(update.toString());
	}
	
	public MessageUtils() {
	}

}
