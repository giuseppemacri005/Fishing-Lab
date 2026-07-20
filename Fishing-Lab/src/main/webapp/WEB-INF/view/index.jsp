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
            boolean isAdmin = "admin".equals(utente.getRuolo());
            if (isAdmin) { 
        %>
                <a href="${pageContext.request.contextPath}/OrdiniServlet">📦 Tutti gli Ordini</a>
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
    // 1. Creazione dell'oggetto XMLHttpRequest 
    var xhr;
    if (window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    } else {
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
    }

    // 2. Definizione della callback al cambio di stato
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // Aggiorna il numero di articoli nel badge del carrello
                document.getElementById('carrello-badge').textContent = xhr.responseText;

                // Mostra il messaggio toast di conferma
                var toast = document.getElementById('messaggio-conferma');
                toast.textContent = "Prodotto \"" + nome + "\" aggiunto al carrello!";
                toast.style.display = 'block';

                setTimeout(function() {
                    toast.style.display = 'none';
                }, 3000);
            } else {
                alert("Errore durante l'aggiunta al carrello (" + xhr.status + ")");
            }
        }
    };

    // 3. Gestione Timeout (15 secondi)
    setTimeout(function() {
        if (xhr.readyState < 4) {
            xhr.abort();
        }
    }, 15000);

    // 4. Preparazione e invio della richiesta POST
    var url = "${pageContext.request.contextPath}/CarrelloServlet";
    var params = "azione=add&id=" + encodeURIComponent(id) + 
                 "&nome=" + encodeURIComponent(nome) + 
                 "&prezzo=" + encodeURIComponent(prezzo);

    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Connection", "close");
    xhr.send(params);
}
</script>