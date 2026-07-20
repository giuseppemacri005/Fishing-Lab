<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Ordine, model.Prodotto, model.Utente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Gestione Ordini (Admin)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Home2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/OrdiniAdmin.css">
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
            <a href="${pageContext.request.contextPath}/OrdiniServlet">📦 Tutti gli Ordini</a>
            <span>Ciao, <%= utente.getNome() %> (Admin)</span>
            <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/LoginServlet">Accedi</a>
        <% } %>
    </div>
</nav>

<div class="admin-orders-container">
    <div class="admin-header">
        <h2>Tutti gli Ordini dei Clienti 📊</h2>
        <span class="badge-total">Totale Ordini: <%= (ordini != null) ? ordini.size() : 0 %></span>
    </div>

    <% if (ordini == null || ordini.isEmpty()) { %>
        <p class="no-data">Nessun ordine presente nel sistema.</p>
    <% } else { %>
        <table class="admin-orders-table">
            <thead>
                <tr>
                    <th>ID Ordine</th>
                    <th>ID Cliente</th>
                    <th>Data</th>
                    <th>Indirizzo</th>
                    <th>Totale</th>
                    <th>Stato</th>
                </tr>
            </thead>
            <tbody>
                <% for (Ordine o : ordini) { %>
                    <tr>
                        <td><strong>#<%= o.getIdOrdine() %></strong></td>
                        <td><span class="user-tag">Utente #<%= o.getIdUtente() %></span></td>
                        <td><%= o.getDataOrdine() %></td>
                        <td><%= o.getIndirizzoSpedizione() != null ? o.getIndirizzoSpedizione() : "N/D" %></td>
                        <td><strong>€ <%= String.format("%.2f", o.getTotale()) %></strong></td>
                        <td>
                            <span class="status-badge status-<%= o.getStato() != null ? o.getStato().toLowerCase().replace(" ", "_") : "completato" %>">
                                <%= o.getStato() != null ? o.getStato() : "Completato" %>
                            </span>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>