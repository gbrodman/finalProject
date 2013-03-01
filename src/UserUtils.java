import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import objects.Achievement;
import objects.Quiz;
import objects.User;
import database.MyDB;


public class UserUtils {
	
	/**
	 * Assumes the user exists!
	 * @param username
	 */
	public static User getUser(String username) {
		String query = "SELECT * FROM users WHERE username=\"" + username + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		
		try {
			int privacySetting = result.getInt("privacySetting");
			boolean isAdmin = result.getInt("isAdmin") == 1;
			String achievementIDs = result.getString("achievementIDs");
			List<Achievement> achievements = AchievementUtils.getAchievements(achievementIDs);
			List<Quiz> quizzes = QuizUtils.getQuizzesByUser(username);
		} catch (SQLException e) {
			e.printStackTrace();
			return new User();
		}
		return new User(); // no.
	}
	


	public UserUtils() {
		// TODO Auto-generated constructor stub
	}

}
