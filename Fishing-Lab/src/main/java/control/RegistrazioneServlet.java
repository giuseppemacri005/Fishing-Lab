package control;

import model.Utente;
import dao.UtenteDAO;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegistrazioneServlet extends HttpServlet {
    private UtenteDAO dao = new UtenteDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        if (nome != null && !nome.isEmpty() && email != null && !email.isEmpty() && pass != null && !pass.isEmpty()) {
            Utente u = new Utente();
            u.setNome(nome);
            u.setCognome(cognome);
            u.setEmail(email);
            u.setPassword(pass);

            if (dao.registra(u)) {
                response.sendRedirect(request.getContextPath() + "/LoginServlet");
            } else {
                request.setAttribute("error", "Errore durante la registrazione. Riprova.");
                request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Tutti i campi sono obbligatori.");
            request.getRequestDispatcher("/WEB-INF/view/registrazione.jsp").forward(request, response);
        }
    }
}