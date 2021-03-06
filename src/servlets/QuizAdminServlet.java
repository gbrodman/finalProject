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
 * Servlet implementation class QuizAdminServlet
 */
@WebServlet("/QuizAdminServlet")
public class QuizAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		int quizID = Integer.parseInt(request.getParameter("quiz"));
		
		RequestDispatcher dispatcher = null;
		if (action.equals("deleteHistory")) {
			QuizResultUtils.deleteAllHistory(quizID);
			dispatcher = request.getRequestDispatcher("DisplayQuiz.jsp");
		} else if (action.equals("deleteQuiz")) {
			QuizUtils.deleteQuiz(quizID);
			dispatcher = request.getRequestDispatcher("QuizList.jsp");
		}
		dispatcher.forward(request, response);
	}

}
