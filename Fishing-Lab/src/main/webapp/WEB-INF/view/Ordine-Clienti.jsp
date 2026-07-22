<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Ordine" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/OrdineClienti.css">
</head>
<body>

<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<main class="orders-container">

    <!-- BOTTONE PER TORNARE ALLA HOME -->
    <div style="margin-bottom: 20px;">
        <a href="${pageContext.request.contextPath}/home" class="btn-home" style="text-decoration: none; padding: 8px 16px; background-color: #007bff; color: white; border-radius: 5px; display: inline-block; font-weight: bold;">
            🏠 Torna alla Home
        </a>
    </div>

    <h2> Ordini effettuati 📦</h2>

    <% if (ordini == null || ordini.isEmpty()) { %>
        <div class="no-orders">
            <p>Non hai ancora effettuato nessun ordine.</p>
        </div>
    <% } else { %>
        <div class="orders-list">
            <% for (Ordine o : ordini) { %>
                <div class="order-card">
                    <div class="order-header">
                        <span class="order-id">Ordine #<%= o.getId_ordine() %></span>
                        <span class="order-date"><%= o.getData_ordine() %></span>
                    </div>

                    <div class="order-details">
                        <p><strong>Totale:</strong> € <%= String.format("%.2f", o.getTotale()) %></p>
                        <% if (o.getIndirizzo() != null) { %>
                            <p><strong>Indirizzo:</strong> <%= o.getIndirizzo() %></p>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</main>

</body>
</html>