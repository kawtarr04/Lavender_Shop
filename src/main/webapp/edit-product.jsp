<%@page import="connection.DBconnection" %>
<%@page import="dao.ProductDAO" %>
<%@page import="model.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null || !"admin".equals(auth.getRole())) {
		response.sendRedirect("login.jsp");
	}

	ProductDAO pd = new ProductDAO(DBconnection.getConnection());
	String productIdParam = request.getParameter("id");

	int productId = 0;
	if (productIdParam != null && !productIdParam.isEmpty()) {
		productId = Integer.parseInt(productIdParam);
	}

	Product productDetail = pd.getSingleProduct(productId);
%>

<!DOCTYPE html>
<html>

<head>
	<%@include file="/includes/head.jsp" %>
	<meta charset="UTF-8">
	<title>Editer Produit</title>
	<style>
		.centered-rectangle {
			background-color: #f5f5f5;
			padding: 30px;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			width: 50%;
			margin: 0 auto;
			max-width: 900px;
			font-family: Georgia, serif;
			color: black;
			line-height: 1.6;
			font-size: 18px;
		}

		.centered-rectangle h2 {
			text-align: center;
			font-size: 24px;
			margin-bottom: 20px;
		}

		.form-group {
			margin-bottom: 20px;
		}

		.form-control,
		.centered-rectangle textarea {
			width: 100%;
			padding: 12px;
			font-size: 16px;
			margin-top: 8px;
			border: 1px solid #ddd;
			border-radius: 5px;
			box-sizing: border-box;
		}

		.centered-rectangle textarea {
			resize: vertical;
			height: 150px;
		}

		.btn-primary {
			background-color: #ddc0ef;
			color: black;
			border: none;
			padding: 10px 20px;
			font-size: 16px;
			border-radius: 5px;
			width: 100%;
		}

		.btn-primary:hover {
			background-color: #c2a7df;
			cursor: pointer;
		}
	</style>
</head>

<body>
<div class="banner">
	<%@include file="/includes/navbar.jsp" %>
	<div class="centered-rectangle">
		<h2>Modifier Produit</h2>
		<form action="update_Product" method="post">
			<input type="hidden" name="id" value="<%= productId %>">
			<div class="form-group">
				<label for="imageproduct">Image :</label>
				<input type="file" class="form-control" id="imageproduct" name="imageproduct" value="<%= productDetail.getImage() %>">
			</div>
			<div class="form-group">
				<label for="productName">Nom du Produit :</label>
				<input type="text" class="form-control" id="productName" name="productName" value="<%= productDetail.getName() %>" required>
			</div>
			<div class="form-group">
				<label for="productCategory">Catégorie :</label>
				<input type="text" class="form-control" id="productCategory" name="productCategory" value="<%= productDetail.getCategory() %>" required>
			</div>
			<div class="form-group">
				<label for="productDescription">Description :</label>
				<textarea class="form-control" id="productDescription" name="productDescription"><%= productDetail.getDescription() %></textarea>
			</div>
			<div class="form-group">
				<label for="productPrice">Prix :</label>
				<input type="number" class="form-control" id="productPrice" name="productPrice" value="<%= productDetail.getPrice() %>" required>
			</div>
			<button type="submit" class="btn-primary">Editer Produit</button>
		</form>
	</div>
</div>
</body>

</html>
