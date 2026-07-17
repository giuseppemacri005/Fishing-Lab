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
        <select name="categoria">
            <option value="tutti">Tutto</option>
            <option value="canne">Canne</option>
            <option value="mulinelli">Mulinelli</option>
            <option value="esche">Esche</option>
            <option value="attrezzatura">Attrezzatura</option>
        </select>
        <input type="search" name="ricerca" placeholder="Cerca attrezzatura...">
        <button type="submit">🔍</button>
    </form>

    <div>
    
        <a href="${pageContext.request.contextPath}/CarrelloServlet">🛒 Carrello 
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
            
            if (prodotti == null) { 
        %>
                <p>Nessun prodotto disponibile al momento.</p>
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
                        
                        <!-- FORM PER AGGIUNGERE AL CARRELLO -->
                       <form action="${pageContext.request.contextPath}/PagProdottoServlet" method="GET">

    <input type="hidden" name="id" value="<%= p.getId_prodotto() %>">
    
    <button type="submit">Vedi Prodotto</button>
</form>
                        </form>
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
        // Aggiorna il badge nella navbar
        document.getElementById('carrello-badge').innerText = data;
        alert("Prodotto aggiunto!");
    })
    .catch(error => console.error('Errore:', error));
}
</script>
</body>
</html>


  