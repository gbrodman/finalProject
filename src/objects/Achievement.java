package objects;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Achievement {

	private int ID;
	private String name;
	private String text;
	
	public Achievement() {
		this(null);
	}

	public Achievement(ResultSet rs) {
		if (rs != null) {
			try {
				this.ID = rs.getInt("achievementID");
				this.name = rs.getString("name");
				this.text = rs.getString("text");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public int getID() {
		return ID;
	}

	public String getName() {
		return name;
	}

	public String getText() {
		return text;
	}

}
