package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import java.util.TreeMap;

import objects.Quiz;
import objects.QuizResult;
import objects.User;

public class QuizResultUtils {
	
	public static int totalNumQuizzesTaken() {
		String query = "SELECT score FROM history;";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}

	public static int numQuizzesTaken(User user) {
		String query = "SELECT score FROM history WHERE user=\""
				+ user.getName() + "\";";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
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
	
	public static int getBestScore(String user, int quizID) {
		String query = "SELECT score FROM history WHERE user=\"" + user+ "\" ORDER BY score DESC;";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			if (rs.next()) {
				QuizResult result = new QuizResult(rs);
				return result.getScore();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public static List<QuizResult> getRecentPerformances(User user) {
		List<QuizResult> toReturn = new ArrayList<QuizResult>();
		String query = "SELECT * FROM history WHERE user=\"" + user.getName() + "\" ORDER BY timeTaken DESC;";
		ResultSet rs = MyDB.queryDatabase(query);
		try { 
			for (int i = 0; i < 5 && rs.next(); i++) {
				toReturn.add(new QuizResult(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return toReturn;
	}
	
	public static int getNumberTimesQuizTaken(int quizID) {
		String query = "SELECT score FROM history WHERE quizID=" + quizID + ";";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}
	
	public static List<Quiz> getMostPopularQuizzes(int numToReturn) {
		List<Quiz> result = new ArrayList<Quiz>();
		List<Quiz> allQuizzes = QuizUtils.getAllQuizzes();
		TreeMap<Integer, List<Quiz>> map = new TreeMap<Integer, List<Quiz>>();
		for (Quiz quiz : allQuizzes) {
			int numTimesTaken = getNumberTimesQuizTaken(quiz.getId());
			if (!map.containsKey(numTimesTaken)) {
				map.put(numTimesTaken, new ArrayList<Quiz>());
			}
			map.get(numTimesTaken).add(quiz);
		}
		for (int i = 0; i < numToReturn && !map.isEmpty();) {
			Entry<Integer, List<Quiz>> entry = map.pollLastEntry();
			for (Quiz quiz : entry.getValue()) {
				result.add(quiz);
				i++;
			}
			map.remove(entry.getKey());
		}
		return result;
	}

	// TODO: figure out what we'll need to do with this.

	public QuizResultUtils() {
	}

}
