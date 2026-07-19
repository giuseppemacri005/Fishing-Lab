package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.Prodotto;
import model.Utente;
import model.Ordine; 
import dao.OrdineDAO; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckoutServlet")
public class ConfermaServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/view/Checkout.jsp").forward(request, response);
    }
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
       
        Utente utente = (Utente) session.getAttribute("utente");
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        
       
        if (utente == null || carrello == null || carrello.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

  
        String indirizzo = request.getParameter("indirizzo");
        if (indirizzo == null || indirizzo.trim().isEmpty()) {
           
            response.sendRedirect(request.getContextPath() + "/CheckoutServlet");
            return;
        }

       
        OrdineDAO ordineDAO = new OrdineDAO();
        
        try {
         
            Ordine o = new Ordine();
            o.setIdUtente(utente.getId_utente()); 
            o.setIndirizzo(indirizzo); 
            o.setTotale(calcolaTotale(carrello));
            
            
            int id_ordine = ordineDAO.inserisciOrdine(o); 
            
           
            if (id_ordine != -1) {
            
                for (Prodotto p : carrello) {
                    ordineDAO.inserisciDettaglio(id_ordine, p);
                }
                
          
                session.removeAttribute("carrello");
                
               
                response.sendRedirect(request.getContextPath() + "/conferma"); 
            } else {
                throw new SQLException("Errore nella creazione dell'ordine nel database.");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    private double calcolaTotale(List<Prodotto> carrello) {
        double totale = 0;
        for (Prodotto p : carrello) {
            totale += p.getPrezzo();
        }
        return totale;
    }
}