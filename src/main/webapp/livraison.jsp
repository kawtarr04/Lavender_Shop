<%@page import="connection.DBconnection" %>
<%@page import="dao.UserDAO" %>
<%@page import="model.*" %>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp");
    }else{

        int userId = auth.getId();
        UserDAO userDB = new UserDAO(DBconnection.getConnection());
        User user = userDB.getUserById(userId);}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Paiement Livraison</title>

    <%@include file="/includes/head.jsp"%>
    <style>
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
    <%@include file="/includes/navbar.jsp"%>
    <div class="centered-rectangle">
        <form action="livraisonServlet" method="post" class="form">
            <h2>Formulaire de Paiement à la Livraison</h2>

            <div class="form-group">
                <label for="nomC">Nom Complet:</label>
                <input type="text" class="form-control" id="nomC" name="nomC" required>
                <br/></div>

            <div class="form-group">
                <label for="numero_tel">Numéro de Téléphone (+212) : </label>
                <input type="text" class="form-control" id="numero_tel" name="numero_tel" pattern="\d{10}" required>
                <br/></div>

            <div class="form-group">
                <label for="adresseMail">Adresse e-mail:</label>
                <input type="text" class="form-control" id="adresseMail" name="adresseMail" required>
                <br/></div>

            <div class="form-group">
                <label for="adresseLivraison">Adresse de Livraison:</label>
                <input type="text" class="form-control" id="adresseLivraison" name="adresseLivraison" required>
                <br/></div>

            <div class="text-center">
                <button type="submit" class="btn">Payer</button></div>
        </form>

        <c:if test="${not empty successMessage}">
            <p class="success" style="color: #77DD77">${successMessage}</p>
        </c:if>


    </div>
</div>
</body>
</html>
