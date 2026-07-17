package control;

import model.Prodotto;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera la sessione
        HttpSession session = request.getSession();
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        
        // Se non esiste, crea un carrello nuovo
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }
        
        // Invia alla pagina JSP che visualizzerà la lista
        request.getRequestDispatcher("/WEB-INF/view/carrello.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        
        if (carrello == null) {
            carrello = new ArrayList<>();
            session.setAttribute("carrello", carrello);
        }

        String azione = request.getParameter("azione");

        if ("add".equals(azione)) {
            // Crea un prodotto con i dati dal form
            Prodotto p = new Prodotto();
            p.setId_prodotto(Integer.parseInt(request.getParameter("id")));
            p.setNome_prodotto(request.getParameter("nome"));
            p.setPrezzo(Double.parseDouble(request.getParameter("prezzo")));
            p.setImmagine(request.getParameter("immagine"));
            p.setDescrizione(request.getParameter("descrizione"));
            
            carrello.add(p);
        } 
        else if ("remove".equals(azione)) {
            int id = Integer.parseInt(request.getParameter("id"));
            // Rimuove il prodotto con quell'ID
            carrello.removeIf(p -> p.getId_prodotto() == id);
        }

        response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
    }
}