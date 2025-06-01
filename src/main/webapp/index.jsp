<%@ page import="connection.DBconnection" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		request.setAttribute("person", auth);
	}
	ProductDAO pd = new ProductDAO(DBconnection.getConnection());
	List<Product> products = pd.getAllProducts();
	ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");

	if (cart_list != null) {
		request.setAttribute("cart_list", cart_list);
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="style.css">
	<title>K ~ SHOP</title>
	<style>
		.product-brand {
			text-transform: uppercase;
			color: #ae95dd;
		}
	</style>
</head>
<body>

<div class="banner">
	<%@include file="/includes/navbar.jsp" %>
	<div class="content">
		<h1>OFFREZ UN INSTANT DE BONHEUR</h1>
		<div>
			<% if (auth != null) { %>
			<!-- Bouton Déconnexion -->
			<a href="log-out">
				<button class="signup-btn" type="button">
					<span class="cover"></span>DÉCONNEXION
				</button>
			</a>
			<% } else { %>
			<!-- Boutons Inscription et Connexion -->
			<a href="signup.jsp">
				<button class="signup-btn" type="button">
					<span class="cover"></span>INSCRIPTION
				</button>
			</a>
			<a href="login.jsp">
				<button class="login-btn" type="button">
					<span class="cover"></span>CONNEXION
				</button>
			</a>
			<% } %>
		</div>
	</div>
</div>

<section class="product" style=": #B19CD9">
	<h2 class="product-category" style="font-family: Georgia, Serif; color: #ae95dd">Nos Bouquets</h2>
	<div class="product-container">
		<% if (!products.isEmpty()) {
			for (Product p : products) { %>
		<div class="product-card">
			<div class="product-image">
				<img src="product-image/<%= (p.getImage() != null && !p.getImage().isEmpty()) ? p.getImage() : "noImage.jpg" %>" class="product-thumb" alt="<%=p.getName()%>">
				<a href="add-to-cart?id=<%=p.getId()%>">
					<button class="card-btn">Ajouter au Panier</button>
				</a>
			</div>
			<div class="product-info">
				<strong><h2><p class="product-brand"><%=p.getName()%></p></h2></strong>
				<p class="product-short-description"><%=p.getCategory()%></p>
				<span class="price"><%=p.getPrice()%> DH</span>
			</div>
		</div>
		<% }
		} else { %>
		<p>Aucun produit disponible</p>
		<% } %>
	</div>
</section>

<script src="script.js"></script>
</body>
</html>