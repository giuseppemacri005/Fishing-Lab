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

    <div class="dashboard-grid">

        <section id="prodotti-section" class="tab-content">
            <h3>🎣 Gestione Catalogo e Prezzi</h3>
            <% if (prodotti == null || prodotti.isEmpty()) { %>
                <div class="empty-state">
                    <p>Nessun prodotto presente a catalogo.</p>
                </div>
            <% } else { %>
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nome Prodotto</th>
                            <th>Prezzo (€)</th>
                            <th>Salva Modifiche</th>
                            <th>Azione</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Prodotto p : prodotti) { %>
                            <tr>
                                <td>#<%= p.getId_prodotto() %></td>
                                
                                <form action="${pageContext.request.contextPath}/AdminProdottoServlet" method="POST" class="inline-form">
                                    <input type="hidden" name="azione" value="modifica">
                                    <input type="hidden" name="id" value="<%= p.getId_prodotto() %>">
                                    
                                    <td>
                                        <input type="text" name="nome" value="<%= p.getnome_prodotto() %>" required class="input-table">
                                    </td>
                                    <td>
                                        <input type="number" name="prezzo" step="0.01" min="0" value="<%= p.getPrezzo() %>" required class="input-table">
                                    </td>
                                    <td>
                                        <button type="submit" class="btn-update">💾 Salva</button>
                                    </td>
                                </form>

                                <td>
                                    <form action="${pageContext.request.contextPath}/AdminProdottoServlet" method="POST" class="inline-form" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
                                        <input type="hidden" name="azione" value="elimina">
                                        <input type="hidden" name="id" value="<%= p.getId_prodotto() %>">
                                        <button type="submit" class="btn-delete">🗑️ Elimina</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>

        <section id="ordini-section" class="tab-content">
            <h3>📦 Tutti gli Ordini Clienti</h3>
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
                            <th>Indirizzo </th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Ordine o : ordini) { %>
                            <tr>
                                <td><strong>#<%= o.getId_ordine() %></strong></td>
                                <td><%= o.getIdUtente() %></td>
                                <td><%= o.getData_ordine() %></td>
                                <td>€ <%= String.format("%.2f", o.getTotale()) %></td>
                                <td><%= o.getIndirizzo() != null ? o.getIndirizzo() : "-" %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </section>

    </div>
</main>

</body>
</html>