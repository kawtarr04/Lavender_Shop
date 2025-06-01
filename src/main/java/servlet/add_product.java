package servlet;


import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add_product")
public class add_product extends HttpServlet {
	private static final long serialVersionUID = 1L;


	private static final String URL = "jdbc:mysql://localhost:3306/ecomm?serverTimezone=UTC";
	private static final String USER = "root";
	private static final String PASSWORD = "";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("add_product.jsp");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nameP = request.getParameter("name");
		String cat = request.getParameter("category");
		String priceStr = request.getParameter("price");
		String img = request.getParameter("image");
		String desc = request.getParameter("description");




		// Validate price
		double prix;
		try {
			prix = Double.parseDouble(priceStr);
		} catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "Prix invalide. Veuillez réessayer.");
			request.getRequestDispatcher("add_product.jsp").forward(request, response);
			return;
		}

		try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
			// Validate connection
			if (connection == null) {
				throw new SQLException("La connexion à la base de données a échoué.");
			}

			// Check if product name already exists
			String checkProductQuery = "SELECT * FROM products WHERE name = ?";
			try (PreparedStatement stmt = connection.prepareStatement(checkProductQuery)) {
				stmt.setString(1, nameP);
				try (ResultSet resultSet = stmt.executeQuery()) {
					if (resultSet.next()) {
						request.setAttribute("errorMessage", "Le nom du produit existe déjà.");
						request.getRequestDispatcher("add_product.jsp").forward(request, response);
						return;
					}
				}
			}

			// Insert product
			String insertProductQuery = "INSERT INTO products (name, category, price, image, description) VALUES (?, ?, ?, ?, ?)";
			try (PreparedStatement insertStmt = connection.prepareStatement(insertProductQuery)) {
				insertStmt.setString(1, nameP);
				insertStmt.setString(2, cat);
				insertStmt.setDouble(3, prix);
				insertStmt.setString(4, img);
				insertStmt.setString(5, desc);
				insertStmt.executeUpdate();
			}

			// Redirect to admin page
			response.sendRedirect("admin.jsp");
		} catch (SQLException e) {
			// Log error and show user-friendly message
			e.printStackTrace();
			request.setAttribute("errorMessage", "Erreur lors de l'ajout du produit : " + e.getMessage());
			request.getRequestDispatcher("add_product.jsp").forward(request, response);
		}
	}
}
