package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import java.util.TreeMap;

import objects.Quiz;
import objects.QuizResult;

public class QuizResultUtils {
	
	public static int totalNumQuizzesTaken() {
		String query = "SELECT score FROM history;";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}

	public static int numQuizzesTaken(String user) {
		String query = "SELECT score FROM history WHERE user=\""
				+ user + "\";";
		ResultSet rs = MyDB.queryDatabase(query);
		return MyDB.numberEntries(rs);
	}

	public static double getAverageScore(String user) {
		String query = "SELECT score FROM history WHERE user=\""
				+ user + "\";";
		return getAverage(query);
	}
	
	private static double getAverage(String query) {
		int totalScore = 0;
		int numQuizzes = 0;
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
		String query = "SELECT score FROM history WHERE user=\"" + user+ "\" AND quizID=" + quizID + " ORDER BY score DESC;";
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
	
	public static List<QuizResult> getRecentPerformances(int quizID, int numResults) {
		String query = "SELECT * FROM history WHERE id=" + quizID + " AND TIMESTAMPDIFF(MINUTE, timeTaken, CURRENT_TIMESTAMP()) < 15 ORDER BY timeTaken DESC;";
		return getNumberOfQuizzes(quizID, numResults, query);
	}
	
	public static List<QuizResult> getTopPerformances(int quizID, int numResults) {
		String query = "SELECT * FROM history WHERE id=" + quizID + " ORDER BY score DESC;";
		return getNumberOfQuizzes(quizID, numResults, query);
	}
	
	public static List<QuizResult> getTopRecentPerformances(int quizID, int numResults) {
		String query = "SELECT * FROM history WHERE id=" + quizID + " AND TIMESTAMPDIFF(MINUTE, timeTaken, CURRENT_TIMESTAMP()) < 15 ORDER BY score DESC;";
		return getNumberOfQuizzes(quizID, numResults, query);
	}
	
	private static List<QuizResult> getNumberOfQuizzes(int quizID, int numResults, String query) {
		List<QuizResult> toReturn = new ArrayList<QuizResult>();
		ResultSet rs = MyDB.queryDatabase(query);
		try { 
			for (int i = 0; i < numResults && rs.next(); i++) {
				toReturn.add(new QuizResult(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return toReturn;
	}
	
	public static List<QuizResult> getRecentPerformances(String user) {
		List<QuizResult> toReturn = new ArrayList<QuizResult>();
		String query = "SELECT * FROM history WHERE user=\"" + user + "\" ORDER BY timeTaken DESC;";
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
	
	public static double getAverageScoreOnQuiz(int quizID) {
		String query = "SELECT * FROM history WHERE quizID=" + quizID + ";";
		return getAverage(query);
	}

	public QuizResultUtils() {
	}

}
