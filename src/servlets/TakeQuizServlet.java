package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.Quiz;
import objects.TakeQuiz;
import database.QuizUtils;

/**
 * Servlet implementation class TakeQuizServlet
 */
@WebServlet("/TakeQuizServlet")
public class TakeQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TakeQuizServlet() {
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
		System.out.println("TakeQuizServlet");
		Quiz quiz = (Quiz)request.getSession().getAttribute("quiz");
		if (quiz == null) quiz = QuizUtils.getQuizByID(Integer.parseInt(request.getParameter("quiz")));
		TakeQuiz takeQuiz = new TakeQuiz(quiz);
		request.getSession().setAttribute("takeQuiz",takeQuiz);
		RequestDispatcher dispatch = request.getRequestDispatcher("ViewQuestion.jsp");
		dispatch.forward(request, response);
	}

}
