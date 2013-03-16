package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.User;
import database.UserUtils;

/**
 * Servlet implementation class UpdateAboutMeServlet
 */
@WebServlet("/UpdateAboutMeServlet")
public class UpdateAboutMeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAboutMeServlet() {
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
		String aboutMe = request.getParameter("aboutMe");
		User user = (User) request.getSession().getAttribute("user");
		user.setAboutMe(aboutMe);
		UserUtils.setAboutMe(user);
		RequestDispatcher dispatch = request.getRequestDispatcher("UserUtilities.jsp"); 
		dispatch.forward(request, response);
	}

}
