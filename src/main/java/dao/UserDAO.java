package dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserDAO {
    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserDAO(Connection con) {
        this.con = con;
    }

    public User userLogin(String email, String password) {
        User user = null;
        try {
            query = "select * from users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }

    // Méthode pour récupérer tous les utilisateurs
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            query = "SELECT * FROM users";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return users;
    }

    // Méthode pour ajouter un nouvel utilisateur
    public boolean addUser(String username,String email, String password) {
        try {
            query = "INSERT INTO users (name, email,password) VALUES (?, ?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            return false;
        }
    }

    // Méthode pour supprimer un utilisateur
    public boolean deleteUser(int userId) {
        try {
            query = "DELETE FROM users WHERE id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.print(e.getMessage());
            return false;
        }
    }

    public boolean updatePassword(int userId, String newPassword) {
        boolean updated = false;

        try {
            String query = "UPDATE users SET password = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
                preparedStatement.setString(1, newPassword);
                preparedStatement.setInt(2, userId);

                int rowsAffected = preparedStatement.executeUpdate();

                updated = rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Gérez les exceptions de manière appropriée dans votre application
        }

        return updated;
    }

    public User getUserById(int userId) {
        User user = null;
        try {
            query = "SELECT * FROM users WHERE id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, userId);
            rs = pst.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password")); // Assure-toi que le champ est correct
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return user;
    }



}
