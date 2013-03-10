package objects;

import java.sql.Timestamp;
import java.util.*;
import objects.*;
import database.*;

public class TakeQuiz {
	
	private List<Question> questions;
	private Quiz quiz;
	private Question curr;
	private List<Integer> scores;
	private int total;
	private Timestamp timeStarted;
	private Timestamp timeCompleted;
	private long timeUsedNum;
	
	public TakeQuiz(Quiz quiz) {
		this.scores = new ArrayList<Integer>();
		java.util.Date today = new java.util.Date();
	    timeStarted = new java.sql.Timestamp(today.getTime());
		this.quiz = quiz;
		this.total = 0;
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
	
	public void quizComplete() {
		java.util.Date today = new java.util.Date();
	    timeCompleted = new java.sql.Timestamp(today.getTime());
	    timeUsedNum = timeCompleted.getTime() - timeStarted.getTime();
	    quiz.incrementNumPlays();
	    QuizUtils.updateNumPlays(quiz);
	}
	
	public long getTimeUsed() {
		return timeUsedNum;
	}
	
	public int getScorePercent() {
		int possible = 0;
		for (Question q : questions) {
			possible += q.getPointValue();
		}
		double dec = (double)total/(double)possible;
		int percent = (int)(dec*100.0);
		return percent;
	}
	
	public void addScore(int index, int value) {
		total += value;
		scores.add(value);
	}
	
	public List<Integer> getScores() {
		return scores;
	}
	
	public List<Question> getQuestions() {
		return questions;
	}
	
	public Timestamp getTimeCompleted() {
		return timeCompleted;
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
