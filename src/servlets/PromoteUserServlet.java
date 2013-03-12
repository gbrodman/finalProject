package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.UserUtils;

/**
 * Servlet implementation class PromoteUserServlet
 */
@WebServlet("/PromoteUserServlet")
public class PromoteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PromoteUserServlet() {
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
		String username = request.getParameter("userToPromote");
		System.out.println(username);
		if (!UserUtils.userExists(username)) {
			RequestDispatcher dispatch = request.getRequestDispatcher("AdminAccountNonexist.jsp");
			dispatch.forward(request, response);
		} else {
			UserUtils.promoteUser(username);
			RequestDispatcher dispatch = request.getRequestDispatcher("AdminSuccess.jsp");
			dispatch.forward(request, response);
		}
	}

}
