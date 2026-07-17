package control;

import model.Prodotto;
import model.Utente;
import dao.OrdineDAO;
import dao.DettaglioOrdineDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CheckoutServlet")
public class ConfermaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

       
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        if (carrello == null || carrello.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }

        // 2. Calcolo totale
        double totale = 0;
        for (Prodotto p : carrello) {
            totale += p.getPrezzo();
        }

      
        OrdineDAO oDao = new OrdineDAO();
        int idOrdine = oDao.inserisciOrdine(utente.getId_utente(), totale);

       
        if (idOrdine != -1) {
            DettaglioOrdineDAO dDao = new DettaglioOrdineDAO();
            for (Prodotto p : carrello) {
                dDao.inserisciDettaglio(idOrdine, p);
            }

         
            session.removeAttribute("carrello");
            response.sendRedirect(request.getContextPath() + "/conferma.jsp");
        } else {
           
            response.sendRedirect(request.getContextPath() + "/carrello.jsp");
        }
    }
}