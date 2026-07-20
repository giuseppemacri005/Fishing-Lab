<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Ordine, model.Prodotto" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pannello Admin - Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/Admin.css">
</head>
<body>

<%
    List<Ordine> ordini = (List<Ordine>) request.getAttribute("ordini");
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
%>

<main class="admin-container">
    <h2>Pannello Controllo Admin ⚙️</h2>

    
    <div class="tab-menu">
        <button class="tab-btn active" onclick="openTab(event, 'ordini-section')">📦 Gestione Ordini</button>
        <button class="tab-btn" onclick="openTab(event, 'prodotti-section')">🎣 Modifica Shop</button>
    </div>

    
    <section id="ordini-section" class="tab-content active">
        <h3>Tutti gli Ordini Clienti</h3>
        <% if (ordini == null || ordini.isEmpty()) { %>
            <div class="empty-state">
                <p>Nessun ordine presente nel sistema.</p>
            </div>
        <% } else { %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID Ordine</th>
                        <th>ID Utente</th>
                        <th>Data</th>
                        <th>Totale</th>
                        <th>Indirizzo Spedizione</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Ordine o : ordini) { %>
                        <tr>
                            <td><strong>#<%= o.getIdOrdine() %></strong></td>
                            <td><%= o.getIdUtente() %></td>
                            <td><%= o.getDataOrdine() %></td>
                            <td>€ <%= String.format("%.2f", o.getTotale()) %></td>
                            <td><%= o.getIndirizzoSpedizione() != null ? o.getIndirizzoSpedizione() : "-" %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </section>


    <section id="prodotti-section" class="tab-content">
        <h3>Gestione Catalogo e Prezzi</h3>
        <% if (prodotti == null || prodotti.isEmpty()) { %>
            <div class="empty-state">
                <p>Nessun prodotto presente a catalogo.</p>
            </div>
        <% } else { %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Prodotto</th>
                        <th>Prezzo Attuale</th>
                        <th>Modifica Prezzo</th>
                        <th>Azione</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Prodotto p : prodotti) { %>
                        <tr>
                            <td>#<%= p.getId() %></td>
                            <td><strong><%= p.getNome() %></strong></td>
                            <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                            
                            
                            <td>
                                <form action="${pageContext.request.contextPath}/AdminProdottoServlet" method="POST" class="inline-form">
                                    <input type="hidden" name="azione" value="aggiornaPrezzo">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <input type="number" name="nuovoPrezzo" step="0.01" min="0" placeholder="€ <%= p.getPrezzo() %>" required>
                                    <button type="submit" class="btn-update">Salva</button>
                                </form>
                            </td>

                           
                            <td>
                                <form action="${pageContext.request.contextPath}/AdminProdottoServlet" method="POST" class="inline-form" onsubmit="return confirm('Sicuro di voler eliminare questo prodotto?');">
                                    <input type="hidden" name="azione" value="elimina">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <button type="submit" class="btn-delete">Elimina</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </section>
</main>


<script>
function mostraScheda(evento, idSezione) {
    // 1. Prendo tutte le sezioni di testo
    var sezioni = document.getElementsByClassName("tab-content");
    
    // Le nascondo tutte una per una
    for (var i = 0; i < sezioni.length; i++) {
        sezioni[i].style.display = "none";
    }

    // 2. Prendo tutti i pulsanti
    var pulsanti = document.getElementsByClassName("tab-btn");
    
    // Tolgo la classe "active" a tutti i pulsanti
    for (var i = 0; i < pulsanti.length; i++) {
        pulsanti[i].className = "tab-btn";
    }

    // 3. Mostro solo la sezione che ha l'ID che ho passato
    document.getElementById(idSezione).style.display = "block";

    // 4. Aggiungo la classe "active" solo al pulsante cliccato
    evento.currentTarget.className = "tab-btn active";
}
</script>

</body>
</html>