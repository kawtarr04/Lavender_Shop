package servlet;

import dao.UserDAO;
import model.User;
import connection.DBconnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PaymentServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Récupération des données du formulaire
        String cardName = request.getParameter("cardName");
        String cardNumber = request.getParameter("cardNumber");
        String expirationDate = request.getParameter("expiration_date");
        String securityCode = request.getParameter("code_secu");

        // Récupération de l'ID de l'utilisateur
        int userId = auth.getId();

        // Connexion à la base de données
        Connection connection = DBconnection.getConnection();
        if (connection != null) {
            try {
                // Préparation de la requête SQL pour insérer les données dans la table payments
                String sql = "INSERT INTO payments (card_name, card_number, expiration_date, security_code, user_id) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, cardName);
                statement.setString(2, cardNumber);
                statement.setString(3, expirationDate);
                statement.setString(4, securityCode);
                statement.setInt(5, userId);

                // Exécution de la requête
                int rowsInserted = statement.executeUpdate();

                // Vérification si l'insertion a réussi
                if (rowsInserted > 0) {
                    request.setAttribute("successMessage", "Paiement effectué avec succès.");
                    request.getRequestDispatcher("payement.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Erreur! Veuillez réessayer.");
                    request.getRequestDispatcher("payement.jsp").forward(request, response);
                }

                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erreur! Veuillez réessayer.");
                request.getRequestDispatcher("payement.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Erreur! Veuillez réessayer.");
            request.getRequestDispatcher("payement.jsp").forward(request, response);
        }
    }
}
