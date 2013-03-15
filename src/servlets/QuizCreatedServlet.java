package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.Achievement;
import objects.Quiz;
import objects.User;
import database.AchievementUtils;
import database.QuizUtils;

/**
 * Servlet implementation class QuizCreatedServlet
 */
@WebServlet("/QuizCreatedServlet")
public class QuizCreatedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizCreatedServlet() {
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
		User user = (User)request.getSession().getAttribute("user");
		List<Quiz> quizzes = QuizUtils.getQuizzesByUser(user.getName(), user);
		Achievement a = null;
		int numQuizzes = quizzes.size();
		if (numQuizzes == 1) {
			a = AchievementUtils.getAchievement(6);
			AchievementUtils.addAchievement(user.getName(), 6);
		}else if (numQuizzes == 5) {
			a = AchievementUtils.getAchievement(1);
			AchievementUtils.addAchievement(user.getName(), 1);
		}else if (numQuizzes == 10) {
			a = AchievementUtils.getAchievement(2);
			AchievementUtils.addAchievement(user.getName(), 2);
		}

		if (a != null) {
			request.getSession().setAttribute("achievement", a);
			RequestDispatcher dispatch = request.getRequestDispatcher("DisplayNewAchievements.jsp");
			dispatch.forward(request, response);
		}else {
			RequestDispatcher dispatch = request.getRequestDispatcher("Homepage.jsp");
			dispatch.forward(request, response);
		}
		
	}

}
