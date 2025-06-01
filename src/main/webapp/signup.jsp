<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<%@include file="/includes/head.jsp"%>
	<title>Inscription</title>
	<style type="text/css">
		.banner {
			display: flex;
			justify-content: center;
			align-items: center
		}
		.centered-rectangle {
			background-color: #f5f5f5;
			padding: 30px;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			width: 50%;
			margin: 50px auto 0 auto;
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
	<div><p>


	</p></div>
	<div class="centered-rectangle">
		<h3>Inscription</h3>
		<form action="add_user" method="post">
			<div class="form-group">
				<label for="name">Nom d'utilisateur</label>
				<input type="text" class="form-control" id="name" name="name" placeholder="Entrez votre nom d'utilisateur" required>
			</div>
			<div class="form-group">
				<label for="email">Adresse e-mail</label>
				<input type="email" class="form-control" id="email" name="email" placeholder="Entrez votre e-mail" required>
			</div>
			<div class="form-group">
				<label for="password">Mot de passe</label>
				<input type="password" class="form-control" id="password" name="password" placeholder="Entrez votre mot de passe" required>
			</div>
			<div class="form-group">
				<label for="confirmPassword">Confirmer le mot de passe</label>
				<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirmez votre mot de passe" required>
			</div>
			<div class="text-center">
				<button type="submit" class="btn">S'inscrire</button>
			</div>
		</form>
		<div class="text-center mt-4">
			<p class="small fw-bold mt-2 pt-1 mb-0">
					Ancien Membre? <a href="login.jsp" class="link-danger">Connectez-vous</a>
			</p>
		</div>
	</div>
</div>
</body>
</html>
