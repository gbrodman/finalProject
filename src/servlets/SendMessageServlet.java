package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import objects.Quiz;
import objects.User;
import database.FriendUtils;
import database.MessageUtils;

/**
 * Servlet implementation class SendMessageServlet
 */
@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMessageServlet() {
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
		User user = (User) request.getSession().getAttribute("user");
		String messageType = request.getParameter("messageType");
		if (messageType.equals("note")) {
			String text = request.getParameter("text");
			String friend = request.getParameter("friend").trim();
			MessageUtils.sendNote(friend, user.getName(), text);
			RequestDispatcher dispatch = request.getRequestDispatcher("MessageFriends.jsp");
			dispatch.forward(request, response);
		} else if (messageType.equals("friendRequest")) {
			String from = user.getName();
			String to = request.getParameter("to");
			FriendUtils.sendFriendRequest(from, to);
			MessageUtils.sendFriendRequest(to, from);
			String pageToOpen = request.getParameter("pageToOpen");
			RequestDispatcher dispatch = request.getRequestDispatcher(pageToOpen);
			dispatch.forward(request, response);
		}
		if (request.getParameter("messageType").equals("challenge")) {
			List<String> friends = FriendUtils.getFriends(user.getName());
			Quiz quiz = (Quiz)request.getSession().getAttribute("quiz");
			for (String friend : friends) {
				System.out.println(friend);
				if (request.getParameter(friend) != null) {
					System.out.println(friend);
					MessageUtils.sendChallenge(friend, user.getName(), quiz.getId());
				}
			}
			RequestDispatcher dispatch = request.getRequestDispatcher("ViewResults.jsp");
			dispatch.forward(request, response);
		}
		// leaves room for sending quiz challenges and such
	}

}
