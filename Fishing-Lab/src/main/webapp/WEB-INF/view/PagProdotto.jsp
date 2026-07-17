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
        <img class="product-img" src="${pageContext.request.contextPath}/images/<%= prodotto.getImmagine() %>" alt="<%= prodotto.getnome_prodotto() %>">
        
        <div class="product-details">
            <p class="product-description"><%= prodotto.getDescrizione() %></p>
            
            <div class="product-price">
                € <%= String.format("%.2f", prodotto.getPrezzo()) %>
            </div>
            
            <div class="product-actions">
                <form id="add-to-cart-form" action="${pageContext.request.contextPath}/CarrelloServlet" method="POST">
                    <input type="hidden" name="azione" value="add">
                    <input type="hidden" name="id" value="<%= prodotto.getId_prodotto() %>">
                    <input type="hidden" name="nome" value="<%= prodotto.getnome_prodotto() %>">
                    <input type="hidden" name="prezzo" value="<%= prodotto.getPrezzo() %>">
                    <button type="submit" id="btn-submit-cart" class="btn-add-cart">Aggiungi al Carrello 🛒</button>
                </form>
                <div id="cart-error-message" style="color: #e53e3e; margin-top: 10px; font-size: 14px;"></div>
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

<script>
document.getElementById('add-to-cart-form').addEventListener('submit', function(event) {
    event.preventDefault(); 

    let datiForm = new URLSearchParams(new FormData(this));
    let errorBox = document.getElementById('cart-error-message');
    
    errorBox.innerText = "";

    fetch(this.action, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: datiForm.toString()
    })
    .then(risposta => {
        if (risposta.ok) {
            document.getElementById('btn-submit-cart').innerText = "Aggiunto! ✓";
            
            setTimeout(function() {
                document.getElementById('btn-submit-cart').innerText = "Aggiungi al Carrello 🛒";
            }, 2000);
        } else {
            errorBox.innerText = "Errore durante l'aggiunta al carrello. Riprova.";
        }
    })
    .catch(errore => {
        errorBox.innerText = "Errore di connessione con il server.";
    });
});
</script>

</body>
</html>