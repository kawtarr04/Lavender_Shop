package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                // Chargement du driver MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connexion à la base de données
                connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/ecomm", // URL de la base de données
                        "root", // Nom d'utilisateur
                        ""      // Mot de passe (mettre à jour si nécessaire)
                );
                System.out.println("Connexion réussie !");
            } catch (ClassNotFoundException e) {
                System.err.println("Erreur : Driver MySQL introuvable !");
                e.printStackTrace();
            } catch (SQLException e) {
                System.err.println("Erreur : Impossible de se connecter à la base de données !");
                e.printStackTrace();
            }
        }
        return connection;
    }
}
