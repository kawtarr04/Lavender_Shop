<%@page import="connection.DBconnection" %>
<%@page import="dao.*" %>
<%@page import="model.*" %>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	User auth = (User) request.getSession().getAttribute("auth");
	if (auth == null) {
		response.sendRedirect("login.jsp");
	}

	int userId = auth.getId();
	UserDAO userDB = new UserDAO(DBconnection.getConnection());
	User user = userDB.getUserById(userId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%@include file="/includes/head.jsp"%>
	<title>Espace User</title>
	<style type="text/css">
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
			width: 100%;
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
		<h3>Espace User</h3>

		<!-- Afficher les informations de l'utilisateur -->
		<h3>Informations Personnelles</h3>
		<p><strong>Nom d'utilisateur:</strong> <%= user.getName() %></p>
		<p><strong>Email:</strong> <%= user.getEmail() %></p>

		<!-- Modifier le mot de passe -->
		<h3>Modifier le Mot de Passe</h3>
		<form action="edit_password" method="post">
			<input type="hidden" name="iduser" value="<%= userId %>">
			<div class="form-group">
				<%--@declare id="currentpassword"--%><label for="currentPassword">Mot de Passe Actuel:</label>
				<input type="password" name="currentPassword" class="form-control" required>
			</div>
			<div class="form-group">
				<%--@declare id="newpassword"--%><label for="newPassword">Nouveau Mot de Passe:</label>
				<input type="password" name="newPassword" class="form-control" required>
			</div>
			<div class="form-group">
				<%--@declare id="confirmpassword"--%><label for="confirmPassword">Confirmer le Nouveau Mot de Passe:</label>
				<input type="password" name="confirmPassword" class="form-control" required>
			</div>
			<div class="text-center">
				<button type="submit" class="btn">Modifier Mot de Passe</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>
