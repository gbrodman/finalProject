package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.Announcement;

public class AnnouncementUtils {

	public static List<Announcement> getAnnouncements() {
		List<Announcement> result = new ArrayList<Announcement>();
		String query = "SELECT * FROM announcements;";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				Announcement next = new Announcement(rs);
				result.add(next);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static void addAnouncement(String text, String creator) {
		String update = "INSERT INTO announcements VALUES(\"" + text + "\",\""
				+ creator + "\");";
		MyDB.updateDatabase(update);
	}

	public AnnouncementUtils() {
	}

}
