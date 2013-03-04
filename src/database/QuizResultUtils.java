package database;

import java.sql.ResultSet;
import java.sql.SQLException;

import objects.User;

public class QuizResultUtils {

	public static int numQuizzesTaken(User user) {
		String query = "SELECT score FROM history WHERE user=\""
				+ user.getName() + "\";";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			rs.last();
			return rs.getRow();
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}

	public static double getAverageScore(User user) {
		int totalScore = 0;
		int numQuizzes = 0;
		String query = "SELECT score FROM history WHERE user=\""
				+ user.getName() + "\";";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				int score = rs.getInt("score");
				totalScore += score;
				numQuizzes++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (numQuizzes == 0) return 0;
		return (double) totalScore / (double) numQuizzes;
	}

	// TODO: figure out what we'll need to do with this.

	public QuizResultUtils() {
	}

}
