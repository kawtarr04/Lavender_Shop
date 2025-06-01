package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.OrderDAO;
import connection.DBconnection;
import model.*;


@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
        User auth = (User) request.getSession().getAttribute("auth");

        if (cart_list != null && auth != null) {
            for (Cart c : cart_list) {
                Order order = new Order();
                order.setId(c.getId());
                order.setUid(auth.getId());
                order.setQuantity(c.getQuantity());
                order.setDate(formatter.format(date));

                OrderDAO oDao = new OrderDAO(DBconnection.getConnection());
                boolean result = oDao.insertOrder(order);
                if (!result) {
                    break;
                }
            }
            cart_list.clear();


            response.sendRedirect("orders.jsp");
            return;
        } else {
            if (auth == null) {

                response.sendRedirect("login.jsp");
                return;
            }

            response.sendRedirect("cart.jsp");
            return;
        }
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
