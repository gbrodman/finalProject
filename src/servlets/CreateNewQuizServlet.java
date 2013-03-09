package servlets;

import java.io.IOException;
import java.util.*;

import objects.*;
import database.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class CreateBlankQuizServlet
 */
@WebServlet("/CreateNewQuizServlet")
public class CreateNewQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateNewQuizServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	private List<String> StringToList(String str) {
		List<String> result = new ArrayList<String>();
		StringTokenizer tokenizer = new StringTokenizer(str);
		while (tokenizer.hasMoreTokens()) {
			String tag = tokenizer.nextToken();
			result.add(tag);
		}
		return result;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("quizTitle");
		String instructions = request.getParameter("quizInstructions");
		String category = request.getParameter("quizCategory");
		List<String> tags = StringToList(request.getParameter("quizTags"));
		boolean isRandom = Boolean.parseBoolean(request.getParameter("isRandomPages"));
		boolean isInstant = Boolean.parseBoolean(request.getParameter("isInstantCorrection"));
		boolean canPractice = Boolean.parseBoolean(request.getParameter("canPractice"));
		Quiz quiz = new Quiz(title, instructions, (User)request.getSession().getAttribute("user"), isRandom, isInstant, canPractice, category, tags);
		QuizUtils.saveQuizInDatabase(quiz);
		request.getSession().setAttribute("currentQuiz", quiz);
		RequestDispatcher dispatch = request.getRequestDispatcher("AddQuestions.jsp");
		dispatch.forward(request, response);
	}

}
