package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import database.UserUtils;

public class User {

	private String name;
	private String photoURL;
	private List<Achievement> achievements; //should probably remove?
	private boolean isAdmin;
	
	// 0 is no privacy, 1 is name-only, 2 is anonymous
	private int privacySetting;
	
	public User() {
		this(null);
	}

	public User(ResultSet rs) {
		if (rs != null) {
			try {
				name = rs.getString("username");
				photoURL = rs.getString("photoURL");
				privacySetting = rs.getInt("privacySetting");
				isAdmin = rs.getInt("isAdmin") == 1;
				photoURL = rs.getString("photoURL");
				String achievementIDs = rs.getString("achievementIDs");
				//achievements = AchievementUtils.getAchievements(achievementIDs);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void changePassword() {
		//implement this
	}

	public void changePhoto(String photoURL) {
		this.photoURL = photoURL;
		UserUtils.updatePhotoURL(this);
		
	}
	
	public String getName() {
		return name;
	}
	
	public String getPhotoURL() {
		return photoURL;
	}
	
	public boolean hasAchievement(Achievement inQuestion) {
		for (Achievement cur : achievements) {
			if (cur.equals(inQuestion)) return true;
		}
		return false;
	}

	public List<Achievement> getAchievements() {
		return achievements;
	}

	public boolean isAdmin() {
		return isAdmin;
	}
	
	public void setAdmin(boolean admin) {
		this.isAdmin = admin;
	}

	public int getPrivacyLevel() {
		return privacySetting;
	}
	
	public void setPrivacyLevel(int setting) {
		privacySetting = setting;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		User other = (User) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
	

}
