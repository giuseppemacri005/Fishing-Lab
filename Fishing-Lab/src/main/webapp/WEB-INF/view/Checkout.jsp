<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/checkout.css">
</head>
<body>

<%
    List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
    double totale = 0.0;
    
 
    if (carrello == null || carrello.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>

<div class="checkout-container"> 
  
    <div class="checkout-main">
        
        <div class="checkout-section dati-cliente">
            <h2>Dati di Spedizione e Pagamento</h2>
            
            <!-- CORREZIONE QUI: puntiamo a /CheckoutServlet -->
            <form action="${pageContext.request.contextPath}/CheckoutServlet" method="POST">
                
                <h3>Indirizzo di Spedizione</h3>
                
                <div class="form-group">
                    <label for="indirizzo">Indirizzo (Via/Piazza e Civico)</label>
                    <input type="text" id="indirizzo" name="indirizzo" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="citta">Città</label>
                        <input type="text" id="citta" name="citta" required>
                    </div>
                    <div class="form-group">
                        <label for="cap">CAP</label>
                        <input type="text" id="cap" name="cap" required maxlength="5">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="telefono">Numero di Telefono</label>
                    <input type="tel" id="telefono" name="telefono" required>
                </div>
                
                <hr class="checkout-divider">
                
                <h3>Dati di Pagamento</h3>
                <div class="form-group">
                    <label for="titolare">Titolare della Carta</label>
                    <input type="text" id="titolare" name="titolareCarta" required>
                </div>
                
                <div class="form-group">
                    <label for="numero-carta">Numero della Carta</label>
                    <input type="text" id="numero-carta" name="numerocarta" required placeholder="0000 0000 0000 0000" maxlength="16">
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="scadenza">Scadenza</label>
                        <input type="text" id="scadenza" name="scadenza" required placeholder="MM/AA" maxlength="5">
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <input type="text" id="cvv" name="cvv" required placeholder="000" maxlength="3">
                    </div>
                </div>
                
                <button type="submit" class="btn-submit-order">Conferma e Paga l'Ordine</button>
            </form>
        </div>
        
       
        <div class="checkout-section order-summary">
            <h2>Il tuo Ordine</h2>
            
            <div class="checkout-items-list">
                <% 
                    for (Prodotto p : carrello) { 
                        totale += p.getPrezzo();
                %>
                    <div class="checkout-item">
                        <span class="checkout-item-name"><%= p.getnome_prodotto() %></span>
                        <span class="checkout-item-price">€ <%= String.format("%.2f", p.getPrezzo()) %></span>
                    </div>
                <% } %>
            </div>
            
            <div class="checkout-total-row">
                <span>Totale da Pagare:</span>
                <span class="checkout-total-amount">€ <%= String.format("%.2f", totale) %></span>
            </div>
            
            <a href="${pageContext.request.contextPath}/carrello.jsp" class="btn-edit-cart">← Modifica Carrello</a>
        </div>
        
    </div>
</div>

</body>
</html>