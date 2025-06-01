<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.*" %>
<%@ page import="model.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="connection.DBconnection" %>
<%@ page import="java.util.ArrayList" %>

<%
	User auth=(User) request.getSession().getAttribute("auth");
	if (auth==null || !"admin".equals(auth.getRole())) {
		response.sendRedirect("login.jsp");
	}

	List<User> users = new UserDAO(DBconnection.getConnection()).getAllUsers();
	List<Product> products = new ProductDAO(DBconnection.getConnection()).getAllProducts();
	List<Order> orders = new OrderDAO(DBconnection.getConnection()).getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%@include file="/includes/head.jsp" %>
	<title>Admin Dashboard</title>
	<style>
		.centered-rectangle {
			background-color: #f5f5f5;
			padding: 30px;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			width: 75%;
			margin: 0 auto;
			max-width: 900px;
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
			margin-top: 20px;
		}

		.centered-rectangle .btn:hover {
			background-color: #c2a7df;
			cursor: pointer;
		}

		.table {
			width: 100%;
			margin-top: 20px;
			border-collapse: collapse;
		}

		.table, .table th, .table td {
			border: 1px solid #ddd;
		}

		.table th, .table td {
			padding: 8px;
			text-align: left;
		}

		.table th {
			background-color: #f2f2f2;
		}

		.form-container input,
		.form-container select {
			padding: 8px;
			margin-right: 10px;
		}

		.form-container button {
			padding: 8px 15px;
		}

		.form-container {
			margin-top: 20px;
		}
	</style>
</head>

<body>
<div class="banner">
	<%@include file="/includes/navbar.jsp" %>

	<div class="centered-rectangle">
		<h3>Admin Dashboard</h3>

		<button class="btn" onclick="showUsers()">Liste des Utilisateurs</button>
		<button class="btn" onclick="showProducts()">Liste des Produits</button>
		<button class="btn" onclick="showOrders()">Liste des Commandes</button>
		<div id="usersContent" style="display: none;">
			<h4>Liste des Utilisateurs</h4>
			<!-- Form to add a new user -->
			<div class="form-container">
				<h4>Ajouter un nouvel utilisateur</h4>
				<form action="add_user" method="post">
					<input type="text" name="name" placeholder="Nom d'utilisateur" required>
					<input type="email" name="email" placeholder="E-mail" required>
					<input type="password" name="password" placeholder="Mot de passe" required>
					<select name="role" required>
						<option value="">User</option>
						<option value="admin">Admin</option>
						<option value="costumer">Costumer</option>
					</select>
					<button type="submit" class="btn">Ajouter</button>
				</form>
			</div>

			<table class="table">
				<thead>
				<tr>
					<th>ID</th>
					<th>Nom d'Utilisateur</th>
					<th>Mot de Passe</th>
					<th>Role</th>
					<th>Action</th>
				</tr>
				</thead>
				<tbody>
				<% for (User user : users) { %>
				<tr>
					<td><%= user.getId() %></td>
					<td><%= user.getName() %></td>
					<td><%= user.getPassword() %></td>
					<td><%= user.getRole() %></td>
					<td>
						<form action="delete_user" method="post" style="display: inline;">
							<input type="hidden" name="id" value="<%= user.getId() %>">
							<button type="submit" class="btn btn-outline-danger">Supprimer</button>
						</form>
					</td>
				</tr>
				<% } %>
				</tbody>
			</table>
		</div>

		<div id="productsContent" style="display: none;">
			<h4>Liste des Produits</h4>
			<!-- Form to add a new product -->
			<div class="form-container">
				<h4>Ajouter un nouveau produit</h4>
				<form action="add_product" method="post">
					<input type="text" name="name" placeholder="Nom du produit" required>
					<input type="text" name="category" placeholder="Catégorie" required>
					<input type="number" name="price" placeholder="Prix" required>
					<input type="file" name="image" placeholder="Image" required>
					<input type="text" name="description" placeholder="Description">
					<button type="submit" class="btn">Ajouter</button>
				</form>
			</div>

			<table class="table">
				<thead>
				<tr>
					<th>ID</th>
					<th>Nom du Produit</th>
					<th>Catégorie</th>
					<th>Prix</th>
					<th>Image</th>
					<th>Modification</th>
					<th>Suppression</th>
				</tr>
				</thead>
				<tbody>
				<% for (Product product : products) { %>
				<tr>
					<td><%= product.getId() %></td>
					<td><%= product.getName() %></td>
					<td><%= product.getCategory() %></td>
					<td><%= product.getPrice() %></td>
					<td><%= product.getImage() %></td>

					<td>
						<a class="btn btn-outline-danger" href="edit-product.jsp?id=<%= product.getId() %>">Modifier</a>
					</td>
					<td>
						<form action="delete_product" method="post" style="display: inline;">
							<input type="hidden" name="id" value="<%= product.getId() %>">
							<button type="submit" class="btn btn-outline-danger">Supprimer</button>
						</form>
					</td>
				</tr>
				<% } %>
				</tbody>
			</table>
		</div>

		<div id="ordersContent" style="display: none;">
			<h4>Liste des Commandes</h4>
			<table class="table">
				<thead>
				<tr>
					<th>Date</th>
					<th>Client</th>
					<th>Produit</th>
					<th>Catégorie</th>
					<th>Quantité</th>
					<th>Prix</th>
					<th>Statut de Paiement</th>
				</tr>
				</thead>
				<tbody>
				<% for (Order order : orders) { %>
				<tr>
					<td><%= order.getDate() %></td>
					<td><%= order.getUserName() %></td>
					<td><%= order.getName() %></td>
					<td><%= order.getCategory() %></td>
					<td><%= order.getQuantity() %></td>
					<td><%= order.getPrice() %></td>
					<td>
						<form action="change_status" method="post" style="display: inline;">
							<input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
							<select name="status" onchange="this.form.submit()" class="btn">
								<option value="" <%= (order.getStatutPaiement() == null || order.getStatutPaiement().isEmpty()) ? "selected" : "" %>>
									Changer le Statut
								</option>
								<option value="En Attente De Paiement"
										<%= "En Attente De Paiement".equals(order.getStatutPaiement()) ? "selected" : "" %>>
									En Attente De Paiement
								</option>
								<option value="Paiement effectué"
										<%= "Paiement effectué".equals(order.getStatutPaiement()) ? "selected" : "" %>>
									Paiement effectué
								</option>
							</select>
						</form>
					</td>


				</tr>
				<% } %>
				</tbody>
			</table>
		</div>

	</div>
</div>

<script>
	function showUsers() {
		document.getElementById('usersContent').style.display = 'block';
		document.getElementById('productsContent').style.display = 'none';
	}

	function showProducts() {
		document.getElementById('productsContent').style.display = 'block';
		document.getElementById('usersContent').style.display = 'none';
	}

	function showOrders() {
		document.getElementById('ordersContent').style.display = 'block';
		document.getElementById('usersContent').style.display = 'none';
		document.getElementById('productsContent').style.display = 'none';
	}
</script>
</body>
</html>
