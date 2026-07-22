<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>

<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    Prodotto prodottoInModifica = (Prodotto) request.getAttribute("prodottoModifica");
    boolean inModifica = (prodottoInModifica != null);
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Catalogo Prodotti</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/adminmodifica2.css">
</head>
<body>

<div>
    <h1>Gestione Catalogo Prodotti</h1>

    <!-- FORM DI INSERIMENTO / MODIFICA -->
    <div>
        <h2><%= inModifica ? "Modifica Prodotto #" + prodottoInModifica.getId_prodotto() : "Aggiungi Nuovo Prodotto" %></h2>
        
        <form action="ProdottoServlet" method="post">
            <!-- Parametro azione nascosto: invia 'update' o 'insert' alla Servlet -->
            <input type="hidden" name="action" value="<%= inModifica ? "update" : "insert" %>">
            
            <% if (inModifica) { %>
                <input type="hidden" name="id" value="<%= prodottoInModifica.getId_prodotto() %>">
            <% } %>

            <p>
                <label for="nome">Nome Prodotto:</label><br>
                <input type="text" id="nome" name="nome" value="<%= inModifica ? prodottoInModifica.getnome_prodotto() : "" %>" required>
            </p>

            <p>
                <label for="descrizione">Descrizione:</label><br>
                <textarea id="descrizione" name="descrizione" rows="3" cols="40"><%= inModifica && prodottoInModifica.getDescrizione() != null ? prodottoInModifica.getDescrizione() : "" %></textarea>
            </p>

            <p>
                <label for="prezzo">Prezzo (€):</label><br>
                <input type="number" step="0.01" id="prezzo" name="prezzo" value="<%= inModifica ? prodottoInModifica.getPrezzo() : "" %>" required>
            </p>

            <!-- CAMPO IMMAGINE COME TESTO (Popolato se inModifica è true) -->
            <p>
                <label for="immagine">Nome File Immagine (es. canna1.jpg):</label><br>
                <input type="text" id="immagine" name="immagine" 
                       value="<%= inModifica && prodottoInModifica.getImmagine() != null ? prodottoInModifica.getImmagine() : "" %>" 
                       placeholder="es. canna1.jpg" required>
            </p>

            <p>
                <button type="submit">
                    <%= inModifica ? "Salva Modifiche" : "Aggiungi Prodotto" %>
                </button>
                
                <% if (inModifica) { %>
                    <a href="ProdottoServlet?action=list">Annulla</a>
                <% } %>
            </p>
        </form>
    </div>

    <hr>

    <!-- TABELLA ELENCO PRODOTTI -->
    <h2>Prodotti in Catalogo</h2>
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>Immagine</th>
                <th>Nome</th>
                <th>Descrizione</th>
                <th>Prezzo</th>
                <th>Azioni</th>
            </tr>
        </thead>
        <tbody>
            <% if (prodotti != null && !prodotti.isEmpty()) { %>
                <% for (Prodotto p : prodotti) { %>
                    <tr>
                        <td><%= p.getId_prodotto() %></td>
                        <td style="text-align: center;">
                            <% if (p.getImmagine() != null && !p.getImmagine().isEmpty()) { %>
                                <img src="${pageContext.request.contextPath}/images/<%= p.getImmagine() %>" 
                                     alt="<%= p.getnome_prodotto() %>" 
                                     style="width: 50px; height: 50px; object-fit: cover; display: block; margin: 0 auto;">
                                <small><%= p.getImmagine() %></small>
                            <% } else { %>
                                <span>-</span>
                            <% } %>
                        </td>
                        <td><%= p.getnome_prodotto() %></td>
                        <td><%= p.getDescrizione() != null ? p.getDescrizione() : "-" %></td>
                        <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                        <td>
                            <a href="ProdottoServlet?action=edit&id=<%= p.getId_prodotto() %>">Modifica</a> | 
                            <a href="ProdottoServlet?action=delete&id=<%= p.getId_prodotto() %>" 
                               onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');">Elimina</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="6" style="text-align: center;">Nessun prodotto presente</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>