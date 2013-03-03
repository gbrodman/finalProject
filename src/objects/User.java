package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import database.AchievementUtils;
import database.QuizUtils;

public class User {

	private String name;
	private List<Message> inbox;
	private List<User> friends;
	private List<Quiz> ownedQuizzes;
	private List<Achievement> achievements;
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
				privacySetting = rs.getInt("privacySetting");
				isAdmin = rs.getInt("isAdmin") == 1;
				String achievementIDs = rs.getString("achievementIDs");
				achievements = AchievementUtils.getAchievements(achievementIDs);
				ownedQuizzes = QuizUtils.getQuizzesByUser(name);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String getName() {
		return name;
	}

	public List<Message> getInbox() {
		return inbox;
	}

	public List<User> getFriends() {
		return friends;
	}

	public List<Quiz> getOwnedQuizzes() {
		return ownedQuizzes;
	}

	public List<Achievement> getAchievements() {
		return achievements;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public int getPrivacyLevel() {
		return privacySetting;
	}
	

}
