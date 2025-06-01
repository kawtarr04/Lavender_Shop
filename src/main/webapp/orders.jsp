<%@page import="java.text.DecimalFormat"%>
<%@page import="connection.DBconnection" %>
<%@page import="dao.OrderDAO" %>
<%@page import="dao.ProductDAO" %>
<%@page import="model.*" %>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf", dcf);
	User auth = (User) request.getSession().getAttribute("auth");
	List<Order> orders = null;
	double totalPrice = 0.0;

	if (auth != null) {
		request.setAttribute("person", auth);
		OrderDAO orderDB  = new OrderDAO(DBconnection.getConnection());
		orders = orderDB.userOrders(auth.getId());

		if (orders != null) {
			for (Order o : orders) {
				totalPrice += o.getPrice();
			}
		}
	}else{
		response.sendRedirect("login.jsp");
	}
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%@include file="/includes/head.jsp"%>
	<title>Commandes</title>
	<style type="text/css">
		/* Styling for centered container and table */
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

		/* Table styling */
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
</head>
<body>

<div class="banner">
	<%@include file="/includes/navbar.jsp"%>
	<div class="centered-rectangle">
		<h3>Toutes les commandes</h3>
		<h4>Prix total des commandes : <%= dcf.format(totalPrice) %> DH</h4>
		<a href="modePay.jsp"><button type="button" class="btn btn-info">Valider le Paiement
		</button></a>
		<table>
			<thead>
			<tr>
				<th scope="col">Date</th>
				<th scope="col">Nom</th>
				<th scope="col">Categorie</th>
				<th scope="col">Quantité</th>
				<th scope="col">Prix</th>
				<th scope="col">Annuler</th>
			</tr>
			</thead>
			<tbody>
			<%
				if (orders != null) {
					for (Order o : orders) {
			%>
			<tr>
				<td><%= o.getDate() %></td>
				<td><%= o.getName() %></td>
				<td><%= o.getCategory() %></td>
				<td><%= o.getQuantity() %></td>
				<td><%= dcf.format(o.getPrice()) %></td>
				<td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%= o.getOrderId() %>">Annuler la commande</a></td>
			</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>
