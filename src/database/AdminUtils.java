package database;

import objects.Quiz;
import objects.User;

public class AdminUtils {
	
	public static void removeUserAccount(String user) {
		String update = "DELETE FROM users WHERE username=\"" + "\";";
		MyDB.updateDatabase(update);
	}
	
	public static void removeQuiz(Quiz quiz) {
		String update = "DELETE FROM quizzes WHERE id=" + quiz.getId() + ";";
		MyDB.updateDatabase(update);
	}
	
	public static void clearHistoryForQuiz(Quiz quiz) {
		String update = "DELETE FROM history WHERE quizID=" + quiz.getId() + ";";
		MyDB.updateDatabase(update);
	}
	
	public static void makeAdmin(User toBeAdmin, User authorizer) {
		if (authorizer.isAdmin()) {
			toBeAdmin.setAdmin(true);
		}
	}

	public AdminUtils() {
	}

}
