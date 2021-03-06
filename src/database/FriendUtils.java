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
	
	public static boolean areFriends(String userOne, String userTwo) {
		List<String> friends = getFriends(userOne);
		return (friends.contains(userTwo));
	}

	public static void sendFriendRequest(String sender, String reciever) {
		MyDB.updateDatabase("INSERT INTO friendsPending VALUES (\"" + sender + "\",\"" + reciever + "\");");
	}

	public static void addFriend(String from, String to) {
		NewsFeedUtils.addEntry(to + " is now friends with " + from, to);
		MyDB.updateDatabase("INSERT INTO friends VALUES (\"" + from + "\",\"" + to + "\", default);");		
	}
	
	public static void removeFromFriendsPending(String user1, String user2) {
		MyDB.updateDatabase("DELETE FROM friendsPending WHERE sender = \"" + user1 + "\" AND recipient=\"" + user2 +"\";");
	}
	
	public static void removeFriend(String user, String otherUser) {
		MyDB.updateDatabase("DELETE FROM friends VALUES (\"" + user + "\",\"" + otherUser + "\");");
		MyDB.updateDatabase("DELETE FROM friends VALUES (\"" + otherUser + "\",\"" + user + "\");");
	}
	
}
