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
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return new User(result);
	}
	
	public void makeAdmin(User toBeAdmin, User authorizer) {
		if (authorizer.isAdmin()) {
			toBeAdmin.setAdmin(true);
		}
	}
	
	public static int getNumberTotalUsers() {
		String query = "SELECT username FROM users;";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			rs.last();
			return rs.getRow();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	


	public UserUtils() {
		// TODO Auto-generated constructor stub
	}

}
