package servlet;

import java.io.IOException;
import java.sql.SQLException;

import dao.UserDAO;
import connection.DBconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class edit_password
 */
@WebServlet("/edit_password")
public class edit_password extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public edit_password() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int userId = Integer.parseInt(request.getParameter("iduser"));
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword.equals(confirmPassword)) {
            // Les mots de passe correspondent, procédez à la modification
            UserDAO userDao;
            userDao = new UserDAO(DBconnection.getConnection());
            if (newPassword.equals(confirmPassword)) {
// Les mots de passe correspondent, procédez à la modification

boolean passwordChanged = userDao.updatePassword(userId, newPassword);
                   response.sendRedirect("settings.jsp");

}

        }
           
	}

}
