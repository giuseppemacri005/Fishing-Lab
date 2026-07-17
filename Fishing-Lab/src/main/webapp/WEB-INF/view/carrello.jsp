<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Il tuo Carrello</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Carrello.css">
</head>
<body>

<%
   //Restituisce la lista 
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    double totale = 0.0;
    //Siccome è booleano controlliamo se il valore e true o false 
    boolean isLoggato = (session.getAttribute("utenteLoggato") != null);
%>

<div class="cart-container">

    <div class="cart-header">
        <h2>Il tuo Carrello 🛒</h2>
        <a href="${pageContext.request.contextPath}/home" class="btn-back">← Torna allo Shop</a>
    </div>

    <% if (carrello == null || carrello.isEmpty()) { %>
      
        <div class="empty-cart">
            <p>Il tuo carrello è attualmente vuoto.</p>
            <p>Non sai da dove iniziare? Dai un'occhiata alle nostre canne ed esche sul catalogo!</p>
            <a href="${pageContext.request.contextPath}/home" class="btn-shop-now">Esplora il catalogo</a>
        </div>
        
    <% } else { %>
        
        <div class="cart-list">
            <% 
                for (Prodotto p : carrello) { 
                    totale += p.getPrezzo();
            %>
                <div class="cart-item">
                    
                    <img class="item-img" src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" alt="<%= p.getnome_prodotto() %>">
                    
                    <div class="item-details">
                        <h3><%= p.getnome_prodotto() %></h3>
                        <p><%= p.getDescrizione() %></p>
                    </div>

                    <div class="item-price">
                        € <%= String.format("%.2f", p.getPrezzo()) %>
                    </div>

                    
                    <form action="${pageContext.request.contextPath}/CarrelloServlet" method="POST">
                        <input type="hidden" name="azione" value="remove">
                        <input type="hidden" name="id" value="<%= p.getId_prodotto() %>">
                        <button type="submit" class="btn-remove">Elimina</button>
                    </form>
                </div>
            <% } %>
        </div>
        
        <<div class="cart-summary">
    <div class="summary-row">
        <span>Totale:</span>
        <span class="total-amount">€ <%= String.format("%.2f", totale) %></span>
    </div>

    <div class="summary-actions">
        <% 
            
            Object utente = session.getAttribute("utenteLoggato"); 
            
            if (utente != null) { 
        %>
          
            <form action="${pageContext.request.contextPath}/ConfermaServlet" method="POST">
                <button type="submit" class="btn-checkout">Procedi all'Ordine ➔</button>
            </form>
        <% 
            } else { 
        %>
          
            <div class="cart-login-notice">
                <p class="Warning">Attenzione: devi accedere per completare l'ordine.</p>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-checkout">Accedi / Registrati</a>
            </div>
        <% 
            } 
        %>
    </div>
</div>

    <% } %>

</div>

</body>
</html>