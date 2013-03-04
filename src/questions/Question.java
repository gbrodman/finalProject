package questions;

import objects.Quiz;

public abstract class Question {

	private int quizID;

	// When reading in from database
	public Question(int quizID) {
		this.quizID = quizID;
	}

	// When a user is creating it
	public Question(Quiz quiz) {
		quizID = quiz.getId();
	}

	public int getQuizID() {
		return quizID;
	}

}
