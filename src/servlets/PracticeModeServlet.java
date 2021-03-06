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
 * Servlet implementation class PracticeModeServlet
 */
@WebServlet("/PracticeModeServlet")
public class PracticeModeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PracticeModeServlet() {
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
		TakeQuiz takeQuiz = new TakeQuiz(quiz);
		takeQuiz.setToPractice();
		request.getSession().setAttribute("takeQuiz",takeQuiz);
		RequestDispatcher dispatch = request.getRequestDispatcher("ViewQuestion.jsp");
		dispatch.forward(request, response);
	}

}
