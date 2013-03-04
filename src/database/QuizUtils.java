package database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.Quiz;


public class QuizUtils {

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

	public QuizUtils() {
		// TODO Auto-generated constructor stub
	}

}
