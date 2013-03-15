package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Announcement {

	private String announcement;
	private String creator;

	public Announcement(ResultSet rs) {
		if (rs != null) {
			try {
				this.announcement = rs.getString("text");
				this.creator = rs.getString("creator");
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

	public String getCreator() {
		return creator;
	}

}
