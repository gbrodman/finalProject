package database;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;

/*
 * CS108 Student: This file will be replaced when we test your code. So, do not add any of your
 * assignment code to this file. Also, do not modify the public interface of this file.
 * Only change the private MySQL constants so that it works with the database login credentials 
 * that we emailed to you.
 * 
 * Usage:
 * Connection con = MyDB.getConnection();
 * 
 * Optional, but recommended: Call the close function when you no longer need to work with the database
 * MyDB.close()
 */
public class MyDB {
	
	private static final String MYSQL_USERNAME = "ccs108gbrodman";
	private static final String MYSQL_PASSWORD = "yeseiboz";
	private static final String MYSQL_DATABASE_SERVER = "mysql-user.stanford.edu";
	private static final String MYSQL_DATABASE_NAME = "c_cs108_gbrodman";
	
	private static Connection con;
	private static Statement stmt;
	
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://" + MYSQL_DATABASE_SERVER + "/" + MYSQL_DATABASE_NAME;
			con = DriverManager.getConnection(url, MYSQL_USERNAME, MYSQL_PASSWORD);
			//stmt = con.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println("CS108 student: Update the MySQL constants to correct values!");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.err.println("CS108 student: Add the MySQL jar file to your build path!");
		}
	}
	
	public static Connection getConnection() {
		return con;
	}
	
	public static void close() {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static ResultSet queryDatabase(String query)  {
		try {
			Statement statement = con.createStatement();
			return statement.executeQuery(query);
		} catch (SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	public static void updateDatabase(String update) {
		try {
			Statement statement = con.createStatement();
			statement.executeUpdate(update);
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
	
	public static void updatePreparedTimestamp(String update, Timestamp time) {
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(update);
			pstmt.setTimestamp(1, time);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static boolean resultIsEmpty(ResultSet result) {
		try {
			result.last();
			int toReturn = result.getRow();
			result.beforeFirst();
			return toReturn == 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return true;
		}
	}
	
	public static int numberEntries(ResultSet result) {
		try {
			result.last();
			int toReturn = result.getRow();
			result.beforeFirst();
			return toReturn;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static String formatDouble(double input) {
		DecimalFormat df = new DecimalFormat("####0.00");
		return df.format(input);
	}
	
}
