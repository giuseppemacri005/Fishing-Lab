<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Ordine, model.Prodotto, model.Utente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - I Miei Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Home2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/OrdiniUtente.css">
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    int count = (carrello != null) ? carrello.size() : 0;
    Utente utente = (Utente) session.getAttribute("utente");
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<nav>
    <a href="${pageContext.request.contextPath}/home">Fishing Lab 🎣</a>

    <form action="${pageContext.request.contextPath}/CercaServlet" method="GET">
        <input type="search" name="ricerca" placeholder="Cerca attrezzatura...">
        <button type="submit">🔍</button>
    </form>

    <div>
        <a href="${pageContext.request.contextPath}/CarrelloServlet">🛒 Carrello 
            <span id="carrello-badge"><%= count > 0 ? count : "" %></span>
        </a>
        
        <% if (utente != null) { %>
            <a href="${pageContext.request.contextPath}/OrdiniServlet">📦 I miei Ordini</a>
            <span>Ciao, <%= utente.getNome() %></span>
            <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/LoginServlet">Accedi</a>
        <% } %>
    </div>
</nav>

<div class="user-orders-container">
    <h2>I Miei Ordini 📦</h2>

    <% if (ordini == null || ordini.isEmpty()) { %>
        <div class="no-orders-box">
            <p>Non hai ancora effettuato nessun ordine.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn-shop">Vai al Catalogo</a>
        </div>
    <% } else { %>
        <div class="orders-list">
            <% for (Ordine o : ordini) { %>
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <span class="order-id">Ordine #<%= o.getIdOrdine() %></span>
                            <span class="order-date"><%= o.getDataOrdine() %></span>
                        </div>
                        <span class="status-badge status-<%= o.getStato() != null ? o.getStato().toLowerCase().replace(" ", "_") : "completato" %>">
                            <%= o.getStato() != null ? o.getStato() : "Completato" %>
                        </span>
                    </div>

                    <div class="order-details">
                        <p><strong>Totale speso:</strong> € <%= String.format("%.2f", o.getTotale()) %></p>
                        <% if (o.getIndirizzoSpedizione() != null) { %>
                            <p><strong>Spedito a:</strong> <%= o.getIndirizzoSpedizione() %></p>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

</body>
</html>