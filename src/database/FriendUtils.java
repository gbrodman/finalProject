package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FriendUtils {

	public static List<String> getFriends(String username) {
		List<String> friends = new ArrayList<String>();
		ResultSet rs = MyDB.queryDatabase("SELECT userOne FROM friends WHERE userTwo = \"" + username + "\" "
				+ "UNION SELECT userTwo FROM friends WHERE userOne = \"" + username + 
				"\";");
		try {
			rs.beforeFirst();
			while (rs.next()) {
				friends.add(rs.getString(1));
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return friends;
	}

	public static List<String> getSentRequests(String username) {
		List<String> requests = new ArrayList<String>();
		ResultSet rs = MyDB.queryDatabase("SELECT recipient FROM friendsPending WHERE sender = \"" + username + "\";");
		try {
			rs.beforeFirst();
			while (rs.next()) {
				requests.add(rs.getString(1));
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return requests;
	}

	public static List<String> getReceivedRequests(String username) {
		List<String> requests = new ArrayList<String>();
		ResultSet rs = MyDB.queryDatabase("SELECT sender FROM friendsPending WHERE recipient = \"" + username + "\";");
		try {
			rs.beforeFirst();
			while (rs.next()) {
				requests.add(rs.getString(1));
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return requests;
	}

	public static void sendFriendRequest(String sender, String reciever) {
		MyDB.updateDatabase("INSERT INTO friendsPending VALUES (\"" + sender + "\",\"" + reciever + "\");");
	}

	public static void acceptFriendRequest(String sender, String recipient) {
		String remove = "DELETE FROM friendsPending WHERE sender=\"" + sender
				+ "\" AND recipient=\"" + recipient + "\";";
		String add = "INSERT INTO friends VALUES(\"" + sender + "\", \"" + recipient + "\");";
		MyDB.updateDatabase(remove);
		MyDB.updateDatabase(add);
	}

}
