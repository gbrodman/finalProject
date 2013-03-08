package objects;

public interface Question {

	int numAnswers();
	String getAnswers();
	int getQuestionType();
	String getQuestionTypeString();
	String getQuestionDisplay();
	String getBody();
	int getPointValue();
	int getQuizID();
	int getOrderInQuiz();
	boolean isCorrect(String answer);
	
}
