<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Accedi</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/login.css">
</head>
<body>

<div class="login-container">
    
    <div class="login-header">
        <a href="${pageContext.request.contextPath}/home" class="logo">Fishing Lab 🎣</a>
        <h2>Bentornato a bordo!</h2>
        <p>Inserisci le tue credenziali per accedere al tuo account</p>
    </div>

    <% 
        String errore = (String) request.getAttribute("errore");
        if (errore != null) { 
    %>
        <div class="error-box">
            <%= errore %>
        </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
        
        <div class="form-group">
            <label for="email">Nome utente o Email</label>
            <input type="email" name="email" placeholder="Email" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Inserisci la tua password" required autocomplete="current-password">
        </div>

        <button type="submit" class="btn-login">Accedi</button>
    </form>

    <div class="login-footer">
        <p>Non hai ancora un account? <a href="${pageContext.request.contextPath}/RegisterServlet">Registrati ora</a></p>
    </div>

</div>

</body>
</html>