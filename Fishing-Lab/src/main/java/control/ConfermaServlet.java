package control;

import java.io.IOException;
import java.util.List;
import model.Prodotto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckoutServlet")
public class ConfermaServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
       
        if (session.getAttribute("utente") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

    
        List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");
        if (carrello == null || carrello.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
            return;
        }

     
        double totale = 0;
        for (Prodotto p : carrello) {
            totale += p.getPrezzo();
        }
        request.setAttribute("totale", totale);

       
        request.getRequestDispatcher("/WEB-INF/view/Checkout.jsp").forward(request, response);
    }
}