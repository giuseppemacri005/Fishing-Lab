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
            // Controllo del ruolo tollerante a maiuscole/minuscole e spazi
            boolean isAdmin = utente.getRuolo() != null && "admin".equalsIgnoreCase(utente.getRuolo().trim());
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
// 1. Funzione per creare XMLHttpRequest (dalle dispense del Prof.)
function createXMLHttpRequest() {
    var request;
    try {
        request = new XMLHttpRequest();
    } catch (e) {
        try {
            request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
                alert("Il browser non supporta AJAX");
                return null;
            }
        }
    }
    return request;
}

// 2. Funzione generica per la chiamata AJAX (dalle dispense del Prof.)
function loadAjaxDoc(url, method, params, cFunction) {
    var request = createXMLHttpRequest();
    if (request) {
        request.onreadystatechange = function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    cFunction(this);
                } else {
                    if (this.status == 0) {
                        alert("Problemi nell'esecuzione della richiesta: nessuna risposta ricevuta nel tempo limite");
                    } else {
                        alert("Problemi nell'esecuzione della richiesta:\n" + this.statusText);
                    }
                    return null;
                }
            }
        };

        // Timeout a 15 secondi con abort()
        setTimeout(function () {
            if (request.readyState < 4) {
                request.abort();
            }
        }, 15000);

        if (method.toLowerCase() == "get") {
            if (params) {
                request.open("GET", url + "?" + params, true);
            } else {
                request.open("GET", url, true);
            }
            request.setRequestHeader("Connection", "close");
            request.send(null);
        } else {
            if (params) {
                request.open("POST", url, true);
                request.setRequestHeader("Connection", "close");
                request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                request.send(params);
            } else {
                console.log("Usa GET se non ci sono parametri!");
                return null;
            }
        }
    }
}

// 3. Callback che gestisce l'aggiornamento della pagina alla risposta
function handleCarrello(request) {
    var count = request.responseText;

    document.getElementById('carrello-badge').textContent = count;

    var toast = document.getElementById('messaggio-conferma');
    toast.textContent = "Prodotto aggiunto al carrello!";
    toast.style.display = 'block';

    setTimeout(function() {
        toast.style.display = 'none';
    }, 3000);
}

// 4. Funzione richiamata al click sul pulsante "Aggiungi al Carrello"
function aggiungiAlCarrello(id, nome, prezzo) {
    var url = "${pageContext.request.contextPath}/CarrelloServlet";
    var params = "azione=add&id=" + id + "&nome=" + encodeURIComponent(nome) + "&prezzo=" + prezzo;
    
    loadAjaxDoc(url, "POST", params, handleCarrello);
}
</script>

</body>
</html>