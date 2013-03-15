package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.*;
import questions.FITBQuestion;
import questions.Question;
import database.*;

/**
 * Servlet implementation class CreateFITBQuestionServlet
 */
@WebServlet("/CreateFITBQuestionServlet")
public class CreateFITBQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateFITBQuestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String body = request.getParameter("questionBody");
		int start = body.indexOf('[');
		int end = body.indexOf(']',start);
		String answer = body.substring(start+1, end);
		String newBody = body.substring(0,start);
		for (int i = 0; i < answer.length(); i++) {
			newBody += '_';
		}
		if (end < body.length()-1) newBody += body.substring(end+1);
		System.out.println(newBody);
		
		String addAns = request.getParameter("questionAnswer");
		if (addAns == null) addAns = "";
		String finalAns = "[" + answer + "]" + addAns;
		int points = Integer.parseInt(request.getParameter("questionPoints"));
		Quiz quiz = (Quiz)request.getSession().getAttribute("currentQuiz");
		Question question = new FITBQuestion(newBody,finalAns,points,quiz.getId(), quiz.numQuestions());
		quiz.incrementNumQuestions();
		QuizUtils.updateNumQuestions(quiz);
		FITBQuestionUtils.saveQuestionInDatabase(question);
		RequestDispatcher dispatch = request.getRequestDispatcher("AddQuestions.jsp");
		dispatch.forward(request, response);
	}

}
