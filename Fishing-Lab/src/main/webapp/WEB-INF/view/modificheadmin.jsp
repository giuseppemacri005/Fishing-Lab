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

<div style="max-width: 1000px; margin: 0 auto; padding: 20px;">
    
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h1>Gestione Catalogo Prodotti</h1>
        <a href="${pageContext.request.contextPath}/home">← Torna alla Home</a>
    </div>

    
    <div style="background-color: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
        <h2><%= inModifica ? "✏️ Modifica Prodotto #" + prodottoInModifica.getId_prodotto() : "➕ Aggiungi Nuovo Prodotto" %></h2>
        
        <form action="ProdottoServlet" method="post">
            <!-- Determina l'azione: 'update' se si modifica, 'insert' se si crea -->
            <input type="hidden" name="action" value="<%= inModifica ? "update" : "insert" %>">
            
            <% if (inModifica) { %>
                <input type="hidden" name="id" value="<%= prodottoInModifica.getId_prodotto() %>">
            <% } %>

            <p>
                <label for="nome"><strong>Nome Prodotto:</strong></label><br>
                <input type="text" id="nome" name="nome" value="<%= inModifica ? prodottoInModifica.getnome_prodotto() : "" %>" style="width: 100%; padding: 8px;" required>
            </p>

            <p>
                <label for="descrizione"><strong>Descrizione:</strong></label><br>
                <textarea id="descrizione" name="descrizione" rows="3" style="width: 100%; padding: 8px;"><%= inModifica && prodottoInModifica.getDescrizione() != null ? prodottoInModifica.getDescrizione() : "" %></textarea>
            </p>

            <p>
                <label for="prezzo"><strong>Prezzo (€):</strong></label><br>
                <input type="number" step="0.01" id="prezzo" name="prezzo" value="<%= inModifica ? prodottoInModifica.getPrezzo() : "" %>" style="width: 100%; padding: 8px;" required>
            </p>

            <p>
                <label for="immagine"><strong>Nome File Immagine (es. canna1.jpg):</strong></label><br>
                <input type="text" id="immagine" name="immagine" 
                       value="<%= inModifica && prodottoInModifica.getImmagine() != null ? prodottoInModifica.getImmagine() : "" %>" 
                       placeholder="es. canna1.jpg" style="width: 100%; padding: 8px;" required>
            </p>

            <p style="margin-top: 15px;">
                <button type="submit" style="padding: 10px 20px; cursor: pointer;">
                    <%= inModifica ? "Salva Modifiche" : "Aggiungi Prodotto" %>
                </button>
                
                <% if (inModifica) { %>
                    <a href="ProdottoServlet?action=list" style="margin-left: 10px;">Annulla Modifica</a>
                <% } %>
            </p>
        </form>
    </div>

    <hr>

   
    <h2>Prodotti in Catalogo</h2>
    <table border="1" cellpadding="10" cellspacing="0" style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background-color: #eee;">
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
                        <td style="text-align: center;"><%= p.getId_prodotto() %></td>
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
                        <td><strong><%= p.getnome_prodotto() %></strong></td>
                        <td><%= p.getDescrizione() != null ? p.getDescrizione() : "-" %></td>
                        <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
                        <td style="text-align: center;">
                            
                            <a href="ProdottoServlet?action=edit&id=<%= p.getId_prodotto() %>">✏️ Modifica</a> 
                            | 
                            
                            <a href="ProdottoServlet?action=delete&id=<%= p.getId_prodotto() %>" 
                               onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');"
                               style="color: red;">🗑️ Elimina</a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="6" style="text-align: center;">Nessun prodotto presente in catalogo.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

</body>
</html>