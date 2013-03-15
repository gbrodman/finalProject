package database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import objects.Quiz;


public class QuizUtils {
	
	public static void deleteQuiz(int quizID) {
		String updateQuiz = "DELETE FROM quizzes WHERE id="+quizID+";";
		//can't just delete quiz and leave questions/history or they appear on later quizzes assigned this id
		String updateFITB = "DELETE FROM fillInTheBlankQuestions WHERE quizID="+quizID+";";
		String updateMC = "DELETE FROM multipleChoiceQuestions WHERE quizID="+quizID+";";
		String updateQR = "DELETE FROM questionResponseQuestions WHERE quizID="+quizID+";";
		String updatePR = "DELETE FROM pictureResponseQuestions WHERE quizID="+quizID+";";
		String updateHistory = "DELETE FROM history WHERE quizID="+quizID+";";
		MyDB.updateDatabase(updateQuiz);
		MyDB.updateDatabase(updateFITB);
		MyDB.updateDatabase(updateMC);
		MyDB.updateDatabase(updateQR);
		MyDB.updateDatabase(updatePR);
		MyDB.updateDatabase(updateHistory);
	}
	
	public static void deleteQuizzesByUser(String username) {
		String query = "SELECT id FROM quizzes WHERE owner=\"" + username + "\"";
		ResultSet rs = MyDB.queryDatabase(query);
		List<Integer> ids = new ArrayList<Integer>();
		try {
			while (rs.next()) {
				int id = rs.getInt("id");
				ids.add(id);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for (int id : ids) {
			deleteQuiz(id);
		}
	}
	
	public static Quiz getQuizByID(int quizID) {
		String query = "SELECT * FROM quizzes WHERE id=" + quizID + ";";
		ResultSet resultSet = MyDB.queryDatabase(query);
		try {
			while (resultSet.next()) {
				return(new Quiz(resultSet));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return (null);
	}

	public static List<Quiz> getQuizzesByUser(String user) {
		List<Quiz> result = new ArrayList<Quiz>();
		String query = "SELECT * FROM quizzes WHERE owner=\"" + user + "\";";
		ResultSet resultSet = MyDB.queryDatabase(query);
		try {
			while (resultSet.next()) {
				Quiz quiz = new Quiz(resultSet);
				result.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static List<String> separateByNullChar(String toSeparate) {
		List<String> result = new ArrayList<String>();
		String[] strings = toSeparate.split("" + '\0');
		for (int i = 0; i < strings.length; i++) {
			result.add(strings[i]);
		}
		return result;
	}
	
	
	public static int getNextId() {
		String query = "SELECT id FROM quizzes ORDER BY id DESC;";
		ResultSet rs = MyDB.queryDatabase(query);
		if (MyDB.resultIsEmpty(rs)) return 0;
		try {
			rs.next();
			int lastId = rs.getInt("id");
			return lastId + 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public static List<Quiz> getQuizzesByTag(String tag) {
		List<Quiz> result = new ArrayList<Quiz>();
		String query = "SELECT * FROM quizzes WHERE tags LIKE '%" + tag + "%';";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				Quiz quiz = new Quiz(rs);
				result.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static List<Quiz> getQuizzesByTitle(String title) {
		List<Quiz> result = new ArrayList<Quiz>();
		String query = "SELECT * FROM quizzes WHERE title LIKE '%" + title + "%';";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				Quiz quiz = new Quiz(rs);
				result.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	public static Map<String, List<Quiz>> getQuizzesByCategory() {
		Map<String, List<Quiz>> result = new HashMap<String, List<Quiz>>();
		String query = "SELECT * FROM quizzes ORDER BY category;";
		ResultSet rs = MyDB.queryDatabase(query);
		String category = "";
		List<Quiz> currentList = null; // will be initialized before we do anything with it
		try {
			while (rs.next()) {
				Quiz quiz = new Quiz(rs);
				if (category.isEmpty() || !category.equals(quiz.getCategory())) {
					if (!category.isEmpty()) {
						result.put(category, currentList);
					}
					category = quiz.getCategory();
					currentList = new ArrayList<Quiz>();
				}
				currentList.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static List<Quiz> getAllQuizzes() {
		List<Quiz> result = new ArrayList<Quiz>();
		String query = "SELECT * FROM quizzes;";
		ResultSet rs = MyDB.queryDatabase(query);
		try {
			while (rs.next()) {
				result.add(new Quiz(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void updateNumQuestions(Quiz quiz) {
		int n = quiz.numQuestions();
		String update = "UPDATE quizzes SET numQuestions="+n+" WHERE id="+quiz.getId()+";";
		MyDB.updateDatabase(update);
	}
	
	public static void updateNumPlays(Quiz quiz) {
		int n = quiz.getNumPlays();
		String update = "UPDATE quizzes SET numPlays="+n+" WHERE id="+quiz.getId()+";";
		MyDB.updateDatabase(update);
	}
	 
	public static void saveQuizInDatabase(Quiz quiz) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO quizzes VALUES(");
		update.append(quiz.getId());
		update.append(",\"");
		update.append(quiz.getTitle());
		update.append("\",\"");
		update.append(quiz.getInstructions());
		update.append("\",");
		update.append(quiz.isInstantCorrection());
		update.append(",");
		update.append(quiz.isRandomPages());
		update.append(",");
		update.append(quiz.isCanPractice());
		update.append(",\"");
		update.append(quiz.getCategory());
		update.append("\",\"");
		update.append(quiz.getTags());
		update.append("\",\"");
		update.append(quiz.getOwner().getName());
		update.append("\",?,");
		update.append(quiz.getNumPlays());
		update.append(",");
		update.append(quiz.numQuestions());
		update.append(");");
		//MyDB.updateDatabase(update.toString());
		MyDB.updatePreparedTimestamp(update.toString(), quiz.getTimeCreated());
		NewsFeedUtils.addQuizEntry(quiz.getOwner().getName() + " created quiz " + quiz.getTitle(), quiz.getOwner().getName(), quiz.getId());
	}
	
	public static List<Quiz> searchQuizzes(String search) {
		Set<Quiz> toReturn = new HashSet<Quiz>();
		toReturn.addAll(getQuizzesByTag(search));
		List<Quiz> byCategory = getQuizzesByCategory().get(search);
		if (byCategory != null) toReturn.addAll(byCategory);
		toReturn.addAll(getQuizzesByUser(search));
		toReturn.addAll(getQuizzesByTitle(search));
		List<Quiz> result = new ArrayList<Quiz>();
		result.addAll(toReturn);
		return result;
	}
	
	public static List<Quiz> getRecentlyCreatedQuizzes(String username) {
		String query = "SELECT * FROM quizzes WHERE owner=\"" + username + "\" AND TIMESTAMPDIFF(MINUTE, timeCreated, CURRENT_TIMESTAMP()) < 15 ORDER BY timeCreated DESC;";
		List<Quiz> toReturn = new ArrayList<Quiz>();
		ResultSet rs = MyDB.queryDatabase(query);
		if (rs == null) System.out.println("NULL");
		try {
			while (rs.next()) {
				Quiz quiz = new Quiz(rs);
				toReturn.add(quiz);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return toReturn;
	}

	public QuizUtils() {
		// TODO Auto-generated constructor stub
	}

}
