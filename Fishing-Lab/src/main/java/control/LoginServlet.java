package control; 

import model.Utente;    
import dao.UtenteDAO;   
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UtenteDAO dao = new UtenteDAO(); // Crea l'istanza del DAO

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Richiama il metodo che abbiamo scritto nel DAO
        Utente u = dao.login(email, pass);

        if (u != null) {
            // Login riuscito: creiamo la sessione
            HttpSession session = request.getSession();
            session.setAttribute("utente", u);
            response.sendRedirect("home"); // Reindirizza alla Home
        } else {
            // Login fallito: torniamo al login con un errore
            request.setAttribute("error", "Email o password errati");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}