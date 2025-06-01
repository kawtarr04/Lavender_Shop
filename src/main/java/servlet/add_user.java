package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add_user")
public class add_user extends HttpServlet {

	private static final String URL = "jdbc:mysql://localhost:3306/ecomm?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String errorMessage = (String) request.getAttribute("errorMessage");
		// Définir le type de contenu de la réponse
		response.setContentType("text/html;charset=UTF-8");
		// Utiliser RequestDispatcher pour transférer la requête vers le fichier JSP
		request.setAttribute("errorMessage", errorMessage);  // Passer l'attribut d'erreur à la JSP
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String pass = request.getParameter("password");

		// Vérifier les informations de connexion
		try {
			// Charger le driver JDBC
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connexion à la base de données
			try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
				// Vérifier si l'email existe déjà dans la base de données
				String checkEmailQuery = "SELECT * FROM users WHERE email = ?";
				try (PreparedStatement stmt = connection.prepareStatement(checkEmailQuery)) {
					stmt.setString(1, email);
					try (ResultSet resultSet = stmt.executeQuery()) {
						if (resultSet.next()) {
							// Si l'email existe déjà, rediriger vers la page de connexion
							request.setAttribute("errorMessage", "L'email existe déjà. Veuillez vous connecter.");
							doGet(request, response);
						} else {
							// Vérifier si le nom d'utilisateur existe déjà
							String checkUsernameQuery = "SELECT * FROM users WHERE name = ?";
							try (PreparedStatement stmt2 = connection.prepareStatement(checkUsernameQuery)) {
								stmt2.setString(1, name);
								try (ResultSet resultSet2 = stmt2.executeQuery()) {
									if (resultSet2.next()) {
										// Si le nom d'utilisateur existe déjà, afficher un message d'erreur
										request.setAttribute("errorMessage", "Le nom d'utilisateur existe déjà.");
										doGet(request, response);
									} else {
										// Si l'email et le nom d'utilisateur n'existent pas, insérer l'utilisateur
										String insertUserQuery = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
										try (PreparedStatement insertStmt = connection.prepareStatement(insertUserQuery)) {
											insertStmt.setString(1, name);
											insertStmt.setString(2, email);
											insertStmt.setString(3, pass);
											insertStmt.executeUpdate();

											// Après l'insertion réussie, rediriger vers admin.jsp
											response.sendRedirect("admin.jsp");
										}
									}
								}
							}
						}
					}
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			response.getWriter().println("<h3>Erreur : " + e.getMessage() + "</h3>");
		}
	}
}
