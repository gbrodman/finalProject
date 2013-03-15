package database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import objects.*;
import questions.MCQuestion;
import questions.Question;

public class MCQuestionUtils {

	public static List<Question> getQuestionsByQuizID(int quizID) {
		List<Question> result = new ArrayList<Question>();
		String query = "SELECT * FROM multipleChoiceQuestions WHERE quizID=\"" + quizID + "\";";
		ResultSet resultSet = MyDB.queryDatabase(query);
		try {
			while (resultSet.next()) {
				Question question = new MCQuestion(resultSet);
				result.add(question);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void addToDatabase(String body,String answer,String choices,int points,int id, int order) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO multipleChoiceQuestions VALUES(\"");
		update.append(body);
		update.append("\",\"");
		update.append(answer);
		update.append("\",\"");
		update.append(choices);
		update.append("\",");
		update.append(points);
		update.append(",");
		update.append(id);
		update.append(",");
		update.append(order);
		update.append(");");
		MyDB.updateDatabase(update.toString());
	}
	
	public static void saveQuestionInDatabase(MCQuestion question) {
		StringBuilder update = new StringBuilder();
		update.append("INSERT INTO multipleChoiceQuestions VALUES(\"");
		update.append(question.getBody());
		update.append("\",\"");
		update.append(question.getAnswers());
		update.append("\",\"");
		update.append(question.getAnswerChoices());
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
