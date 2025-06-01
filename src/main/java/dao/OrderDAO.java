package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import model.*;

public class OrderDAO {

    private Connection con;

    private String query;
    private PreparedStatement pst;
    private ResultSet rs;



    public OrderDAO(Connection con) {
        super();
        this.con = con;
    }

    public boolean insertOrder(Order model) {
        boolean result = false;
        try {
            query = "insert into orders (p_id, u_id, o_quantity, o_date) values(?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getId());
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getQuantity());
            pst.setString(4, model.getDate());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return result;
    }


    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from orders where u_id=? order by orders.o_id desc";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDAO productDao = new ProductDAO(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice()*rs.getInt("o_quantity"));
                order.setQuantity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }

    public void cancelOrder(int id) {
        //boolean result = false;
        try {
            query = "delete from orders where o_id=?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.execute();
            //result = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        //return result;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        try {
            query = "SELECT orders.*, users.name AS user_name, validation.statut_paiement " +
                    "FROM orders " +
                    "JOIN users ON orders.u_id = users.id " +
                    "LEFT JOIN validation ON orders.o_id = validation.o_id " +
                    "ORDER BY orders.o_id DESC";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDAO productDao = new ProductDAO(this.con);
                int pId = rs.getInt("p_id");
                Product product = productDao.getSingleProduct(pId);
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setQuantity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                order.setUserName(rs.getString("user_name"));
                // Ajouter le statut de paiement
                order.setStatutPaiement(rs.getString("statut_paiement"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return list;
    }


    public void updatePaymentStatus(int orderId, String status) {
        try {
            // Vérifier si l'entrée existe déjà
            query = "SELECT * FROM validation WHERE o_id = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, orderId);
            rs = pst.executeQuery();

            if (rs.next()) {
                // Mettre à jour le statut si l'entrée existe
                query = "UPDATE validation SET statut_paiement = ? WHERE o_id = ?";
                pst = this.con.prepareStatement(query);
                pst.setString(1, status);
                pst.setInt(2, orderId);
            } else {
                // Insérer une nouvelle ligne si elle n'existe pas
                query = "INSERT INTO validation (o_id, statut_paiement) VALUES (?, ?)";
                pst = this.con.prepareStatement(query);
                pst.setInt(1, orderId);
                pst.setString(2, status);
            }
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
}
