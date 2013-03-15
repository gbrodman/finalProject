package database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import objects.Achievement;


public class AchievementUtils {

	public AchievementUtils() {
		// TODO Auto-generated constructor stub
	}
	public static List<Achievement> getAchievements(String ids) {
		List<Achievement> result = new ArrayList<Achievement>();
		StringTokenizer tokenizer = new StringTokenizer(ids);
		while (tokenizer.hasMoreTokens()) {
			String token = tokenizer.nextToken();
			int achId = Integer.parseInt(token);
			result.add(getAchievement(achId));
		}
		return result;
	}
	
	public static List<Achievement> getAchievementsForUser(String user) {
		List<Achievement> achievements = new ArrayList<Achievement>();
		String query = "SELECT * FROM achievementEvents WHERE user=\"" + user + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		try {
			result.beforeFirst();
			while (result.next()) {
				int type = result.getInt("type");
				achievements.add(getAchievement(type));
			}
		} catch(SQLException e) {
			e.printStackTrace();
			return achievements;
		}
		return achievements;
	}
	
	public static void addAchievement(String user, int achievementID) {
		String update = "INSERT INTO achievementEvents VALUES(\""+user+"\", "+achievementID+", default)";
		MyDB.updateDatabase(update);
	}
	
	public static Achievement getAchievement(int achievementID) {
		String query = "SELECT * FROM achievements WHERE achievementID=\"" + achievementID + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		try {
			result.next();
			return new Achievement(result);
		} catch (SQLException e) {
			e.printStackTrace();
			return new Achievement();
		}
	}
}
