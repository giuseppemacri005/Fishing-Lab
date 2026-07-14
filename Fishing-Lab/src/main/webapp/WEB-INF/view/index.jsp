<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto, model.Utente" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/home.css">
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    int count = (carrello != null) ? carrello.size() : 0;
    Utente utente = (Utente) session.getAttribute("utente");
%>

<div class="aquarium"></div>

<nav>
    <a href="${pageContext.request.contextPath}/home">Fishing Lab 🎣</a>

    <form action="${pageContext.request.contextPath}/CercaServlet" method="GET">
        <input type="search" name="ricerca" placeholder="Cerca attrezzatura...">
        <button type="submit">🔍</button>
    </form>

    <div>
        <a href="${pageContext.request.contextPath}/carrello.jsp">🛒 Carrello 
            <span id="carrello-badge"><%= count > 0 ? count : "" %></span>
        </a>
        
        <% if (utente != null) { %>
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
            if (prodotti != null) {
                for (Prodotto p : prodotti) {
        %>
                <div class="product-card">
                    <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" alt="Prodotto">
                    <div>
                        <h5><%= p.getnome_prodotto() %></h5>
                        <p><%= p.getDescrizione() %></p>
                        <p>€ <%= String.format("%.2f", p.getPrezzo()) %></p>
                        <button type="button" onclick="aggiungiAlCarrello('<%= p.getId_prodotto() %>')">Aggiungi</button>
                    </div>
                </div>
        <%      } 
            }
        %>
    </div>
</div>

<script>
function aggiungiAlCarrello(id) {
    fetch('${pageContext.request.contextPath}/CarrelloServlet?idProdotto=' + id, {
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => response.text())
    .then(count => {
        // 1. Aggiorna il numero del carrello
        document.getElementById('carrello-badge').innerText = count;

        // 2. DOM: Mostra il messaggio di conferma
        const msg = document.getElementById('messaggio-conferma');
        msg.style.display = 'block';

        // 3. (Opzionale) Nascondi il messaggio automaticamente dopo 3 secondi
        setTimeout(() => {
            msg.style.display = 'none';
        }, 3000);
    });
}
</script>
</body>
</html>