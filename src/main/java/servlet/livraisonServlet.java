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

@WebServlet("/livraisonServlet")

public class livraisonServlet extends HttpServlet{
    private static final String URL = "jdbc:mysql://localhost:3306/ecomm?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errorMessage = (String) request.getAttribute("errorMessage");
        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("#").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nomC = request.getParameter("nomC");
        int numero_tel = Integer.parseInt(request.getParameter("numero_tel"));
        String adresseMail = request.getParameter("adresseMail");
        String adresseLivraison = request.getParameter("adresseLivraison");

        try {
            // Charger le driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connexion à la base de données
            try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
                                        String insertUserQuery = "INSERT INTO livraison (nomC, numero_tel, adresseMail, adresseLivraison) VALUES (?, ?, ?, ?)";
                                        try (PreparedStatement insertStmt = connection.prepareStatement(insertUserQuery)) {
                                            insertStmt.setString(1, nomC);
                                            insertStmt.setInt(2, numero_tel);
                                            insertStmt.setString(3, adresseMail);
                                            insertStmt.setString(4, adresseLivraison);
                                            insertStmt.executeUpdate();

                                            request.setAttribute("successMessage", "Commande en cours de traitement.");
                                            request.getRequestDispatcher("livraison.jsp").forward(request, response);

                                        }
            }
        } catch (SQLException | ClassNotFoundException e) {
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }
}
