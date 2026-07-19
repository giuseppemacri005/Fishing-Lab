<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Ordine Confermato</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/ConfermaOrdine.css">
</head>
<body>

<div class="success-container">
    <div class="success-card">
        <!-- Icona di successo (un segno di spunta visivo) -->
        <div class="success-icon">✓</div>
        
        <h1>Grazie per il tuo acquisto!</h1>
        <p class="success-message">Il tuo ordine è stato ricevuto con successo ed è in fase di elaborazione.</p>
        
        <div class="order-details-box">
            <p><strong>Stato dell'ordine:</strong> In lavorazione</p>
            <p><strong>Spedizione:</strong> Riceverai una mail con il tracciamento appena il corriere prenderà in carico il pacco.</p>
        </div>
        
        <p class="assistance-text">Per qualsiasi domanda o modifica al tuo ordine, contatta l'assistenza clienti indicando i tuoi dati.</p>
        
        <div class="actions-row">
            <a href="${pageContext.request.contextPath}/home" class="btn-continue-shopping">Torna allo Shop</a>
        </div>
    </div>
</div>

</body>
</html>