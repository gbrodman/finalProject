import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import objects.Achievement;
import database.MyDB;


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
	
	public static Achievement getAchievement(int achievementID) {
		String query = "SELECT * FROM achievements WHERE achievementID=\"" + achievementID + "\";";
		ResultSet result = MyDB.queryDatabase(query);
		try {
			String name = result.getString("name");
			String text = result.getString("text");
			return new Achievement(achievementID, name, text);
		} catch (SQLException e) {
			e.printStackTrace();
			return new Achievement();
		}
	}
}
