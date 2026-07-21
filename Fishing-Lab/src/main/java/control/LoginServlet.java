package control; 

import model.Utente;    
import dao.UtenteDAO;   
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UtenteDAO dao = new UtenteDAO(); 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

       
        Utente u = dao.login(email, pass);

        if (u != null) {
          
            HttpSession session = request.getSession();
            session.setAttribute("utente", u);
           
            response.sendRedirect(request.getContextPath() + "/home");
        }
     else {
      
        request.setAttribute("errore", "Email o Password errate!");
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
     }}}