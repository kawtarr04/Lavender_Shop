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
  <title>Paiement par carte</title>

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

      .message {
          padding: 15px;
          margin-bottom: 20px;
          border-radius: 5px;
          font-weight: bold;
      }

      .success {
          background-color: #d4edda;
          color: #246132;
      }

      .error {
          background-color: #f8d7da;
          color: #852e36;
      }
</style>
</head>
<body>
<div class="banner">
  <%@include file="/includes/navbar.jsp"%>
  <div class="centered-rectangle">
      <%
          String successMessage = (String) request.getAttribute("successMessage");
          String errorMessage = (String) request.getAttribute("errorMessage");
      %>

      <% if (successMessage != null) { %>
      <div class="message success">
          <%= successMessage %>
      </div>
      <% } %>

      <% if (errorMessage != null) { %>
      <div class="message error">
          <%= errorMessage %>
      </div>
      <% } %>
  <form action="PaymentServlet" method="post" class="form">
  <h2>Formulaire de Paiement par Carte Bancaire</h2>

    <div class="form-group">
    <label for="cardName">Nom du Titulaire de la Carte:</label>
    <input type="text" class="form-control" id="cardName" name="cardName" required>
    <br/></div>

    <div class="form-group">
    <label for="cardNumber">Numéro de Carte:</label>
    <input type="text" class="form-control" id="cardNumber" name="cardNumber" pattern="\d{16}" required>
        <br/></div>

    <div class="form-group">
    <label for="expiration_date">Date d'Expiration:</label>
    <input type="text" class="form-control" id="expiration_date" name="expiration_date" placeholder="MM/AA" pattern="(0[1-9]|1[0-2])\/\d{2}" required>
        <br/></div>

    <div class="form-group">
    <label for="code_secu">Code de Sécurité (CVV/CVC):</label>
    <input type="text" class="form-control" id="code_secu" name="code_secu" pattern="\d{3,4}" required>
        <br/></div>

    <div class="text-center">
        <button type="submit" class="btn">Payer</button></div>
  </form>
    </div>
</div>
</body>
</html>
