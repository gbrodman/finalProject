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
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ID;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((text == null) ? 0 : text.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Achievement other = (Achievement) obj;
		if (ID != other.ID)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (text == null) {
			if (other.text != null)
				return false;
		} else if (!text.equals(other.text))
			return false;
		return true;
	}

}
