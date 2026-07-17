package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recupera la sessione corrente, se esiste
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Invalida la sessione (elimina tutti i dati associati)
            session.invalidate();
        }
        
        // 3. Reindirizza l'utente alla home o alla pagina di login
        response.sendRedirect(request.getContextPath() + "/home");
    }
}