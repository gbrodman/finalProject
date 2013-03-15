package objects;

import java.sql.Timestamp;
import java.util.*;
import objects.*;
import database.*;

public class TakeQuiz {
	
	private List<Question> questions;
	private List<Question> unUsed;
	private Random r;
	private Quiz quiz;
	private Question curr;
	private int[] scores;
	private int total;
	private Timestamp timeStarted;
	private Timestamp timeCompleted;
	private long timeUsedNum;
	private boolean isPractice;
	private boolean instantCorrect;
	private boolean isRandom;
	
	public void initializeUnused() {
		unUsed = new ArrayList<Question>();
		for (Question q : questions) {
			int type = q.getQuestionType();
			Question newQ = null;
			if (type == 1) newQ = new QRQuestion(q.getBody(), q.getAnswers(), q.getPointValue(), q.getQuizID(), q.getOrderInQuiz());
			else if (type == 2) newQ = new FITBQuestion(q.getBody(), q.getAnswers(), q.getPointValue(), q.getQuizID(), q.getOrderInQuiz());
			else if (type == 3) newQ = new MCQuestion(q.getBody(), q.getAnswers(), q.getAnswerChoices(), q.getPointValue(), q.getQuizID(), q.getOrderInQuiz());
			else if (type == 4) newQ = new PRQuestion(q.getBody(), q.getAnswers(), q.getURL(), q.getPointValue(), q.getQuizID(), q.getOrderInQuiz());
			unUsed.add(newQ);
		}
	}
	
	public TakeQuiz(Quiz quiz) {
		r = new Random();
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
		initializeUnused();
		this.instantCorrect = quiz.isInstantCorrection();
		this.isRandom = quiz.isRandomPages();
		this.curr = null;
		this.scores = new int[quiz.numQuestions()];
		this.isPractice = false;
	}
	
	public boolean isRandom() {
		return isRandom;
	}
	
	public void setToPractice() {
		isPractice = true;
	}
	
	public boolean isPractice() {
		return isPractice;
	}
	
	public boolean isInstantCorrect() {
		return instantCorrect;
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
	
	public void addScore(int value, int index) {
		total += value;
		scores[index] = value;
	}
	
	public int[] getScores() {
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
	
	public Question getRandomNext() {
		if (curr != null) unUsed.remove(curr);
		int size = unUsed.size();
		if (size == 0) return null;
		int i = r.nextInt(size);
		curr = unUsed.get(i);
		return curr;
	}
	
}
