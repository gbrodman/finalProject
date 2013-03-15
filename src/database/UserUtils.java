package database;

import java.sql.ResultSet;
import java.sql.SQLException;

import objects.User;


public class UserUtils {
	
	/**
	 * Assumes the user exists!
	 * @param username
	 */
	public static User getUser(String username) {
		String query = "SELECT * FROM users WHERE username=\"" + username + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		try {
			result.next();
			return new User(result);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void removeUser(String username) {
		String update = "DELETE FROM users WHERE username=\"" + username + "\";";
		MyDB.updateDatabase(update);
	}
	
	public static void promoteUser(String username) {
		String update = "UPDATE users SET isAdmin=1 WHERE username=\"" + username + "\";";
		MyDB.updateDatabase(update);
	}
	
	public static boolean userExists(String username, User userViewing) {
		String query = "SELECT * FROM users WHERE username=\"" + username + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		if (MyDB.resultIsEmpty(result)) return false;
		try {
			result.next();
			User user = new User(result);
			if (!username.equals(userViewing.getName()) && user.getPrivacyLevel() == 2 && !FriendUtils.areFriends(username, userViewing.getName())) {
				return false;
			}
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static int getNumberTotalUsers() {
		String query = "SELECT username FROM users;";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}
	
	public static void updatePhotoURL(User user) {
		String update = "UPDATE users SET photoURL=\""+user.getPhotoURL()+"\" WHERE username=\""+user.getName()+"\";";
		MyDB.updateDatabase(update);
	}

	public UserUtils() {
		// TODO Auto-generated constructor stub
	}

}
