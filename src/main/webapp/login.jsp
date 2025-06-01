<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth != null) {
		response.sendRedirect("index.jsp");
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
	<title>Connexion</title>
	<style type="text/css">
		/* Styling for centered container */
		.centered-rectangle {
			background-color: #f5f5f5;
			padding: 30px;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			width: 50%;
			margin: 0 auto;
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

		.centered-rectangle form {
			margin-top: 20px;
		}

		.centered-rectangle label {
			font-size: 16px;
		}

		.centered-rectangle .form-control {
			font-size: 16px;
			padding: 10px;
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

		.centered-rectangle .link-danger {
			color: #e5affa;
			text-decoration: none;
			font-weight: bold;
		}

		.centered-rectangle .link-danger:hover {
			text-decoration: underline;
		}
		.centered-rectangle .form-group {
			margin-bottom: 30px;
		}

		.text-center {
			text-align: center;
		}
	</style>
</head>
<body>
<div class="banner">
<%@include file="/includes/navbar.jsp"%>

<div class="centered-rectangle">
	<h3>Connexion</h3>
	<form action="user-login" method="post">
		<div class="form-group">
			<label>Adresse email</label>
			<input type="email" name="login-email" class="form-control" placeholder="Entrez votre email">
		</div>
		<div class="form-group">
			<label>Mot de Passe</label>
			<input type="password" name="login-password" class="form-control" placeholder="Mot de passe">
		</div>

		<!-- Error message display -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger text-center" role="alert">
					${errorMessage}
			</div>
		</c:if>

		<div class="text-center">
			<button type="submit" class="btn">Connexion</button>
		</div>
	</form>
	<div class="text-center mt-4">
		<p class="small fw-bold mt-2 pt-1 mb-0">
			Nouveau Membre ? <a href="signup.jsp" class="link-danger">S'inscrire</a>
		</p>
	</div>
</div>
</div>
</body>
</html>
