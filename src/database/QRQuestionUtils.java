package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.*;

public class QRQuestionUtils {

	public static List<Question> getQuestionsByQuizID(int quizID) {
		List<Question> result = new ArrayList<Question>();
		String query = "SELECT * FROM questionResponseQuestions WHERE quizID=\"" + quizID + "\";";
		ResultSet resultSet = MyDB.queryDatabase(query);
		try {
			while (resultSet.next()) {
				Question question = new QRQuestion(resultSet);
				result.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void saveQuestionInDatabase(Question question) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO questionResponseQuestions VALUES(\"");
		update.append(question.getBody());
		update.append("\",\"");
		update.append(question.getAnswers());
		update.append("\",");
		update.append(question.getPointValue());
		update.append(",");
		update.append(question.getQuizID());
		update.append(",");
		update.append(question.getOrderInQuiz());
		update.append(");");
		MyDB.updateDatabase(update.toString());
	}
}
