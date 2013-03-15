package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.NewsFeedEntry;

public class NewsFeedUtils {
	
	public static void addQuizEntry(String text, String user, int quizID) {
		String update = "INSERT INTO newsFeed VALUES(\"" + text + "\", CURRENT_TIMESTAMP, \"" + user + "\", 1, " + quizID + ");";
		MyDB.updateDatabase(update);
	}
	public static void addEntry(String text, String user) {
		String update = "INSERT INTO newsFeed VALUES(\"" + text + "\", CURRENT_TIMESTAMP, \"" + user + "\", 0, -1);";
		MyDB.updateDatabase(update);
	}
	
	public static List<NewsFeedEntry> getMostRecentEntries(String currentUser, int maxEntries) {
		String query = "SELECT * FROM newsFeed ORDER BY time DESC;";
		ResultSet rs = MyDB.queryDatabase(query);
		List<NewsFeedEntry> toReturn = new ArrayList<NewsFeedEntry>();
		try {
			int i = 0;
			while (rs.next() && i < maxEntries) {
				NewsFeedEntry entry = new NewsFeedEntry(rs);
				String user = entry.getUser();
				if (user.equals(currentUser) || FriendUtils.areFriends(user, currentUser)) {
					toReturn.add(entry);
					i++;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return toReturn;
	}

	public NewsFeedUtils() {
		// TODO Auto-generated constructor stub
	}

}
