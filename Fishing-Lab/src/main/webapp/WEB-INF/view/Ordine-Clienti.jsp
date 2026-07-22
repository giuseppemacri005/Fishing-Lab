<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Ordine" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>I miei Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/OrdineClienti.css">
</head>
<body>

<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
%>

<main class="orders-container">
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