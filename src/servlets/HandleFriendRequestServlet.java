package servlets;


import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.*;

import database.*;

/**
 * Servlet implementation class HandleFriendRequestServlet
 */
@WebServlet("/HandleFriendRequestServlet")
public class HandleFriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleFriendRequestServlet() {
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
		String friend_response = request.getParameter("status");
		Message message = (Message)request.getSession().getAttribute("currentMessage");
		if (friend_response.equals("accept")) {
			System.out.println("ACCEPT");
			FriendUtils.addFriend(message.getUserFrom(), message.getUserTo());
		} else {
			System.out.println("REJECT");
		}
		FriendUtils.removeFromFriendsPending(message.getUserFrom(), message.getUserTo());
		MessageUtils.removeMessage(message);
		RequestDispatcher dispatch = request.getRequestDispatcher("Messages.jsp");
		dispatch.forward(request, response);
	}

}
