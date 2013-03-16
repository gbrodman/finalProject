package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.User;
import database.FriendUtils;
import database.MessageUtils;

/**
 * Servlet implementation class RejectFriendRequestServlet
 */
@WebServlet("/RejectFriendRequestServlet")
public class RejectFriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RejectFriendRequestServlet() {
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
		String userTo = ((User) request.getSession().getAttribute("user")).getName();
		String userFrom = request.getParameter("userFrom");
		int messageID = Integer.parseInt(request.getParameter("messageID"));
		
		FriendUtils.removeFromFriendsPending(userFrom, userTo);
		FriendUtils.removeFromFriendsPending(userTo, userFrom);
		
		MessageUtils.removeMessage(messageID);
		
		RequestDispatcher dispatch = request.getRequestDispatcher("Messages.jsp");
		dispatch.forward(request, response);
	}

}
