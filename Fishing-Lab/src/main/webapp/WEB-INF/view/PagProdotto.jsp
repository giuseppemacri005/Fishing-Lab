<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Dettaglio Prodotto</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Prodotto.css">
</head>
<body>

<%
    
    Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
    
    if (prodotto != null) {
%>

<div class="product-container">


    <div class="product-header">
        <h2><%= prodotto.getnome_prodotto() %></h2>
        <a href="${pageContext.request.contextPath}/home" class="btn-back">← Torna allo Shop</a>
    </div>

    <div class="product-content">
        <!-- Immagine del prodotto -->
        <img class="product-img" src="${pageContext.request.contextPath}/images/<%= prodotto.getImmagine() %>" alt="<%= prodotto.getnome_prodotto() %>">
        
        <!-- Dettagli del prodotto (Descrizione e Prezzo) -->
        <div class="product-details">
            <p class="product-description"><%= prodotto.getDescrizione() %></p>
            
            <div class="product-price">
                € <%= String.format("%.2f", prodotto.getPrezzo()) %>
            </div>
            
            <!-- Aggiunta al carrello -->
            <div class="product-actions">
                <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST">
                    <input type="hidden" name="azione" value="add">
                    <input type="hidden" name="id" value="<%= prodotto.getId_prodotto() %>">
                    <button type="submit" class="btn-add-cart">Aggiungi al Carrello 🛒</button>
                </form>
            </div>
        </div>
    </div>

</div>

<% 
    } else { 
%>
    <div class="product-container">
        <p>Prodotto non trovato o non disponibile.</p>
        <a href="${pageContext.request.contextPath}/home">Torna al catalogo</a>
    </div>
<% 
    } 
%>

</body>
</html>