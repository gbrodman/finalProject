package objects;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.AchievementUtils;
import database.FriendUtils;
import database.MessageUtils;
import database.QuizUtils;

public class User {

	private String name;
	private String photoURL;
	private List<Message> inbox;
	private List<String> friends;
	private List<String> friendRequestsSent;
	private List<String> friendRequestsRecieved;
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
				photoURL = rs.getString("photoURL");
				privacySetting = rs.getInt("privacySetting");
				isAdmin = rs.getInt("isAdmin") == 1;
				photoURL = rs.getString("photoURL");
				friends = FriendUtils.getFriends(name);
				friendRequestsSent = FriendUtils.getSentRequests(name);
				friendRequestsRecieved = FriendUtils.getReceivedRequests(name);
				String achievementIDs = rs.getString("achievementIDs");
				achievements = AchievementUtils.getAchievements(achievementIDs);
				ownedQuizzes = QuizUtils.getQuizzesByUser(name);
				inbox = MessageUtils.getMessagesByUserTo(name);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public String getName() {
		return name;
	}
	
	public String getPhotoURL() {
		return photoURL;
	}

	public List<Message> getInbox() {
		return inbox;
	}
	
	public List<Message> getUnreadMessages() {
		List<Message> result = new ArrayList<Message>();
		for (Message message : inbox) {
			if (!message.isViewed()) {
				result.add(message);
			}
		}
		return result;
	}

	public List<String> getFriends() {
		return friends;
	}
	
	public List<String> getFriendRequestsSent() {
		return friendRequestsSent;
	}
	
	public List<String> getFriendRequestsRecieved() {
		return friendRequestsRecieved;
	}

	public List<Quiz> getOwnedQuizzes() {
		return ownedQuizzes;
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
