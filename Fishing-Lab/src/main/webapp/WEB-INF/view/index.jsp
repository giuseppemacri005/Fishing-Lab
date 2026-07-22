<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto, model.Utente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Home2.css">
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    int count = (carrello != null) ? carrello.size() : 0;
    Utente utente = (Utente) session.getAttribute("utente");
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
        
        <% if (utente != null) { 
            String ruolo = utente.getRuolo();
            boolean isAdmin = (ruolo != null && ruolo.trim().equalsIgnoreCase("admin"));
            
            if (isAdmin) { 
        %>
        <a href="${pageContext.request.contextPath}/ProdottoServlet" class="btn-admin">⚙️ Pannello Modifiche Admin</a>
                <a href="${pageContext.request.contextPath}/OrdiniServlet">📦 Zona Admin</a>
        <%  } else { %>
                <a href="${pageContext.request.contextPath}/OrdiniServlet">📦 I miei Ordini</a>
        <%  } %>

            <span>Ciao, <%= utente.getNome() %></span>
            <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/LoginServlet">Accedi</a>
        <% } %>
    </div>
</nav>

<div>
    <h2>Il nostro Catalogo</h2>
    <div class="product-list">
        <% 
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            
            if (prodotti == null || prodotti.isEmpty()) { 
        %>
                <p class="error-message">Nessun prodotto disponibile al momento.</p>
        <% 
            } else {
                for (Prodotto p : prodotti) {
        %>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" alt="Prodotto">
                    <div>
                        <h5><%= p.getnome_prodotto() %></h5>
                        <p><%= p.getDescrizione() %></p>
                        <p>€ <%= String.format("%.2f", p.getPrezzo()) %></p>
                        
                        <!-- Bottone per visualizzare il dettaglio del singolo prodotto -->
                        <a href="${pageContext.request.contextPath}/PagProdottoServlet?id=<%= p.getId_prodotto() %>" class="btn-vedi-prodotto">Vedi Prodotto</a>
                    </div>
                </div>
        <%      } 
            }
        %>
    </div>
</div>

</body>
</html>