package objects;

import java.util.*;
import objects.*;
import database.*;

public class TakeQuiz {
	
	private List<Question> questions;
	private Quiz quiz;
	private Question curr;
	
	public TakeQuiz(Quiz quiz) {
		this.quiz = quiz;
		List<Question> questionList = new ArrayList<Question>();
		List<Question> qrQuestions = QRQuestionUtils.getQuestionsByQuizID(quiz.getId());
		List<Question> fitbQuestions = FITBQuestionUtils.getQuestionsByQuizID(quiz.getId());
		List<Question> prQuestions = PRQuestionUtils.getQuestionsByQuizID(quiz.getId());
		List<Question> mcQuestions = MCQuestionUtils.getQuestionsByQuizID(quiz.getId());
		//eventually add all question types
		questionList.addAll(fitbQuestions);
		questionList.addAll(qrQuestions);
		questionList.addAll(prQuestions);
		questionList.addAll(mcQuestions);
		Comparator<Question> questionComparator = new Comparator<Question>() {
			public int compare(Question q1, Question q2) {
				return (q1.getOrderInQuiz()-q2.getOrderInQuiz());
			}
		};
		Collections.sort(questionList, questionComparator);
		this.questions = questionList;
		this.curr = null;
	}
	
	public Question getCurrentQuestion() {
		return curr;
	}
	
	public Quiz getQuiz() {
		return quiz;
	}
	
	public Question nextQuestion() {
		int index;
		if (curr == null) index = -1;
		else index = curr.getOrderInQuiz();
		if (index >= questions.size()-1) return null;
		curr = questions.get(index+1);
		return curr;
	}
	
}
