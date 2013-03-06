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
	
	public static int getNumberTotalUsers() {
		String query = "SELECT username FROM users;";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}
	


	public UserUtils() {
		// TODO Auto-generated constructor stub
	}

}
