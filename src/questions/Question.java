package questions;

import java.util.Comparator;
import java.util.*;

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
	public String getInstantQuestion();
	public String getInstantCorrectResult(String ans);
	public String getURL();
	public String getAnswerChoices();
	
}
