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

<!-- Elemento toast per il messaggio di conferma -->
<div id="messaggio-conferma" style="display:none; position:fixed; top:20px; right:20px; background:#38a169; color:white; padding:15px; border-radius:5px; z-index:1000; box-shadow:0 4px 6px rgba(0,0,0,0.1);"></div>

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
                    <input type="hidden" name="immagine" value="<%= prodotto.getImmagine() %>">
                    <input type="hidden" name="descrizione" value="<%= prodotto.getDescrizione() %>">
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

    let errorBox = document.getElementById('cart-error-message');
    errorBox.innerText = "";

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
                let btn = document.getElementById('btn-submit-cart');
                btn.innerText = "Aggiunto! ✓";

                // Mostra il messaggio toast di conferma
                var toast = document.getElementById('messaggio-conferma');
                toast.textContent = "Prodotto aggiunto al carrello con successo!";
                toast.style.display = 'block';

                setTimeout(function() {
                    btn.innerText = "Aggiungi al Carrello 🛒";
                    toast.style.display = 'none';
                }, 3000);
            } else {
                errorBox.innerText = "Errore durante l'aggiunta al carrello (" + xhr.status + ")";
            }
        }
    };

    // 3. Gestione Timeout (15 secondi)
    setTimeout(function() {
        if (xhr.readyState < 4) {
            xhr.abort();
        }
    }, 15000);

    // 4. Preparazione dei parametri dal form
    var url = this.action;
    var params = "azione=add" +
                 "&id=" + encodeURIComponent(this.id.value) + 
                 "&nome=" + encodeURIComponent(this.nome.value) + 
                 "&prezzo=" + encodeURIComponent(this.prezzo.value) +
                 "&immagine=" + encodeURIComponent(this.immagine.value) +
                 "&descrizione=" + encodeURIComponent(this.descrizione.value);

    // 5. Apertura e invio della richiesta POST
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Connection", "close");
    xhr.send(params);
});
</script>

</body>
</html>