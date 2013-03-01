package objects;

import java.util.ArrayList;
import java.util.List;

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
		this("", new ArrayList<Message>(), new ArrayList<User>(), new ArrayList<Quiz>(), new ArrayList<Achievement>(), false, 0);
	}

	public User(String name, List<Message> inbox, List<User> friends, List<Quiz> ownedQuizzes, List<Achievement> achievements, boolean isAdmin, int privacySetting) {
		this.name = name;
		this.inbox = inbox;
		this.friends = friends;
		this.ownedQuizzes = ownedQuizzes;
		this.achievements = achievements;
		this.privacySetting = privacySetting;
		this.isAdmin = isAdmin;
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
