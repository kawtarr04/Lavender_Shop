<%@page import="connection.DBconnection"%>
<%@page import="dao.ProductDAO"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDAO pDB = new ProductDAO(DBconnection.getConnection());
	cartProduct = pDB.getCartProducts(cart_list);
	double total = pDB.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%@include file="/includes/head.jsp"%>
	<title>Panier</title>
	<style type="text/css">
	.table tbody td {
		vertical-align: middle;
	}
	
	.btn-incre, .btn-decre {
		box-shadow: none;
		font-size: 25px;
	}
	</style>
</head>
<body>


	<div class="banner">
		<%@include file="/includes/navbar.jsp"%>
		<div class="centered-rectangle">
			<h3>Prix Total: ${(total > 0) ? dcf.format(total) : 0} DH</h3>
			<a href="cart-check-out" class="btn">Valider Achats</a>
			<table>
				<thead>
				<tr>
					<th>Nom</th>
					<th>Catégorie</th>
					<th>Prix</th>
					<th>Quantité</th>
					<th>Annuler</th>
				</tr>
				</thead>
				<tbody>
				<% if (cart_list != null) {
					for (Cart c : cartProduct) { %>
				<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td><%= dcf.format(c.getPrice()) %></td>
					<td>
						<form action="order-now" method="post">
							<input type="hidden" name="id" value="<%= c.getId() %>">
							<input type="number" name="quantity" value="<%= c.getQuantity() %>" style="width: 50px;">
							<button type="submit" class="btn btn-primary">Acheter</button>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%= c.getId() %>" class="btn btn-danger">Annuler</a></td>
				</tr>
				<% }} %>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>

<style>
	.centered-rectangle {
		background-color: #f5f5f5;
		padding: 20px;
		border-radius: 10px;
		box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		width: 80%;
		margin: 20px auto;
		font-family: Georgia, serif;
		color: black;
		line-height: 1.6;
		font-size: 18px;
	}

	.centered-rectangle h3 {
		text-align: center;
		font-size: 24px;
		margin-bottom: 20px;
	}

	.centered-rectangle .btn {
		display: inline-block;
		padding: 10px 20px;
		font-size: 16px;
		text-decoration: none;
		text-align: center;
		color: black;
		background-color: #ddc0ef;
		border-radius: 5px;
		margin: 10px 0;
	}

	/* Style for the table */
	.centered-rectangle table {
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}

	.centered-rectangle th,
	.centered-rectangle td {
		border: 1px solid #ddd;
		padding: 10px;
		text-align: center;
	}

	.centered-rectangle th {
		background-color: #ddc0ef;
		font-weight: bold;
	}

	.centered-rectangle td {
		vertical-align: middle;
	}

	.centered-rectangle .btn-danger {
		background-color: #e4befb;
		color: white;
		padding: 5px 10px;
		font-size: 14px;
		border-radius: 5px;
	}

	.centered-rectangle .btn-primary {
		font-size: 14px;
	}
</style>