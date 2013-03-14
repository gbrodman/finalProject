package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.*;
import database.*;

/**
 * Servlet implementation class CreatePRQuestionServlet
 */
@WebServlet("/CreatePRQuestionServlet")
public class CreatePRQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreatePRQuestionServlet() {
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
		String answer = request.getParameter("questionAnswer");
		String url = request.getParameter("photoURL");
		int points = Integer.parseInt(request.getParameter("questionPoints"));
		Quiz quiz = (Quiz)request.getSession().getAttribute("currentQuiz");
		PRQuestion question = new PRQuestion(body,answer,url,points,quiz.getId(),quiz.numQuestions());
		quiz.incrementNumQuestions();
		QuizUtils.updateNumQuestions(quiz);
		PRQuestionUtils.saveQuestionInDatabase(question);
		RequestDispatcher dispatch = request.getRequestDispatcher("AddQuestions.jsp");
		dispatch.forward(request, response);
	}

}
