package servlet;

import java.io.IOException;
import java.sql.SQLException;

import dao.ProductDAO;
import connection.DBconnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class update_Product
 */
@WebServlet("/update_Product")
public class update_Product extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public update_Product() {
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
		
		int id = Integer.parseInt(request.getParameter("id"));
		String img = request.getParameter("imageproduct");
		String nameP = request.getParameter("productName");
		String cat = request.getParameter("productCategory");
		String desp = request.getParameter("productDescription");
		double prix = Double.parseDouble(request.getParameter("productPrice"));
		
		ProductDAO pdt;
        pdt = new ProductDAO(DBconnection.getConnection());

        pdt.updateProduct(id, nameP,  cat, desp, prix,  img);
        response.sendRedirect("admin.jsp");

    }


}
