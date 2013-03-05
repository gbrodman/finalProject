package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.Message;
import objects.User;

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
	
	public static void sendFriendRequest(User userTo, User userFrom) {
		Message message = new Message(userTo, userFrom, false, true, false, -1, -1, userTo.getName() + " wants to be friends with you!");
		sendMessage(message);
	}
	
	public static void sendNote(User userTo, User userFrom, String note) {
		Message message = new Message(userTo, userFrom, false, false, true, -1, -1, note);
		sendMessage(message);
	}
	
	public static void sendChallenge(User userTo, User userFrom, int quizID) {
		int bestScore = QuizResultUtils.getBestScore(userTo, quizID);
		String note = userTo.getName() + " has challenged you to a quiz! Their best score was " + bestScore + "%. Click on the link to try to beat it.";
		Message message = new Message(userTo, userFrom, true, false, false, quizID, bestScore, note);
		sendMessage(message);
	}
	
	private static void sendMessage(Message message) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO messages VALUES(\"");
		update.append(message.getUserTo().getName());
		update.append("\",\"");
		update.append(message.getUserFrom().getName());
		update.append(",");
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
		update.append("\";");
		MyDB.updateDatabase(update.toString());
	}
	
	public MessageUtils() {
	}

}
