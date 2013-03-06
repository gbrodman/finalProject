package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.UserUtils;

public class Announcement {

	private String announcement;
	private User creator;

	public Announcement(ResultSet rs) {
		if (rs != null) {
			try {
				this.creator = UserUtils.getUser(rs.getString("creator"));
				this.announcement = rs.getString("announcement");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public Announcement() {
		this(null);
	}

	public String getAnnouncement() {
		return announcement;
	}

	public User getCreator() {
		return creator;
	}

}