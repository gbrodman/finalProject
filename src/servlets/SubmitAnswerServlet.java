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
 * Servlet implementation class SubmitAnswerServlet
 */
@WebServlet("/SubmitAnswerServlet")
public class SubmitAnswerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitAnswerServlet() {
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
		TakeQuiz takeQuiz = (TakeQuiz)request.getSession().getAttribute("takeQuiz");
		Question question = takeQuiz.getCurrentQuestion();
		String answer = request.getParameter("answer");
		System.out.println(answer);
		if (question.isCorrect(answer)) {
			takeQuiz.addScore(question.getOrderInQuiz(), question.getPointValue());
			System.out.println("CORRECT!");
		}
		else {
			takeQuiz.addScore(question.getOrderInQuiz(), 0);
			System.out.println("WRONG");
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("ViewQuestion.jsp");
		dispatch.forward(request, response);
	}

}
