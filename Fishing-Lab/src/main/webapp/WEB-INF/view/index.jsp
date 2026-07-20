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

<div id="messaggio-conferma"></div>

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
            boolean isAdmin = "ADMIN".equalsIgnoreCase(utente.getRuolo());
            if (isAdmin) { 
        %>
                <a href="${pageContext.request.contextPath}/OrdiniServlet?action=tutti">📦 Tutti gli Ordini</a>
        <%  } else { %>
                <a href="${pageContext.request.contextPath}/OrdiniServlet?action=miei">📦 I miei Ordini</a>
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
                        
                        <button type="button" onclick="aggiungiAlCarrello('<%= p.getId_prodotto() %>', '<%= p.getnome_prodotto() %>', <%= p.getPrezzo() %>)">
                            Aggiungi al Carrello
                        </button>
                    </div>
                </div>
        <%      } 
            }
        %>
    </div>
</div>

<script>
function aggiungiAlCarrello(id, nome, prezzo) {
    const formData = new URLSearchParams();
    formData.append('azione', 'add');
    formData.append('id', id);
    formData.append('nome', nome);
    formData.append('prezzo', prezzo);

    fetch('${pageContext.request.contextPath}/CarrelloServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        document.getElementById('carrello-badge').textContent = data;

        const toast = document.getElementById('messaggio-conferma');
        toast.textContent = "Prodotto \"" + nome + "\" aggiunto al carrello!";
        toast.style.display = 'block';

        setTimeout(() => {
            toast.style.display = 'none';
        }, 3000);
    })
    .catch(error => console.error('Errore:', error));
}
</script>

</body>
</html>