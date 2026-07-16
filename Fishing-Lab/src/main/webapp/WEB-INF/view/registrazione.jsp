<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fishing Lab - Registrati</title>
    <!-- 
       [CSS ESTERNO]: Collegamento al foglio di stile dedicato alla registrazione.
       Il parametro ?v=... con il timestamp evita che il browser salvi il CSS in cache durante lo sviluppo.
    -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Registrazione.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<!-- 
   [.register-container]: Il box bianco centrale che racchiude tutto il modulo.
   Nel CSS, questa classe imposta la larghezza, lo sfondo bianco e l'ombra sfumata.
-->
<div class="register-container">
    
    <!-- 
       [.register-header]: Gestisce la spaziatura e l'allineamento dei testi in cima.
    -->
    <div class="register-header">
        <!-- [.logo]: Colora il link di blu notte, lo ingrandisce e toglie la sottolineatura -->
        <a href="${pageContext.request.contextPath}/home" class="logo">Fishing Lab 🎣</a>
        <h2>Crea il tuo account</h2>
        <p>Unisciti alla nostra community di pescatori!</p>
    </div>

  
    <% 
        String errore = (String) request.getAttribute("errore");
        if (errore != null) { 
    %>
        <div class="error-box">
            <%= errore %>
        </div>
    <% } %>

    <!-- Form di Registrazione che punta alla tua Servlet di registrazione -->
    <form action="${pageContext.request.contextPath}/RegistrazioneServlet" method="POST">
        
       
        <div class="form-row">
           
            <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" placeholder="Es. Mario" required>
            </div>

            <div class="form-group">
                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" placeholder="Es. Rossi" required>
            </div>
        </div>

        <div class="form-group">
            <label for="email">Indirizzo Email</label>
            <input type="email" id="email" name="email" placeholder="mario.rossi@esempio.com" required autocomplete="email">
        </div>

        <div class="form-group">
            <label for="username">Nome utente (Username)</label>
            <input type="text" id="username" name="username" placeholder="Scegli un username" required autocomplete="username">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Minimo 8 caratteri" required autocomplete="new-password">
        </div>

        <div class="form-group">
            <label for="confermaPassword">Conferma Password</label>
            <input type="password" id="confermaPassword" name="confermaPassword" placeholder="Ripeti la password" required autocomplete="new-password">
        </div>

        
        <button type="submit" class="btn-register">Registrati</button>
    </form>

   
    <div class="register-footer">
        <p>Hai già un account? <a href="${pageContext.request.contextPath}/login.jsp">Accedi qui</a></p>
    </div>

</div>

</body>
</html>