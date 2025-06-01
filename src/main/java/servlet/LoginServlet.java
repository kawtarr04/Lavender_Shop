package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDAO;
import connection.DBconnection;
import model.User;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String email = request.getParameter("login-email");
		String password = request.getParameter("login-password");

		UserDAO udao = new UserDAO(DBconnection.getConnection());
		User user = udao.userLogin(email, password);
		if (user != null) {
			// Si l'utilisateur est trouvé, créer une session et rediriger vers la page d'accueil
			request.getSession().setAttribute("auth", user);
			response.sendRedirect("index.jsp");
		} else {
			// Si l'email ou le mot de passe est incorrect, afficher un message d'erreur
			request.setAttribute("errorMessage", "Adresse Email ou Mot de Passe Introuvables");
			// Rediriger vers la page de connexion avec l'attribut d'erreur
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
