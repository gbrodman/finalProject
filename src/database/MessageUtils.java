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
	public MessageUtils() {
	}

}
