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
	
	public MessageUtils() {
	}

}
