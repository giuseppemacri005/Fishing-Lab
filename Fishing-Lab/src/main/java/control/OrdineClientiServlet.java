package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.OrdineDAO;
import model.Ordine;
import model.Utente;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrdiniServlet")
public class OrdineClienteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");

      
        if (utente == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> ordini = null;

        try {
         
            String ruolo = utente.getRuolo();
            boolean isAdmin = (ruolo != null && ruolo.trim().equalsIgnoreCase("admin"));

            if (isAdmin) {
                ordini = ordineDAO.getTuttiGliOrdini();
            } else {
                ordini = ordineDAO.getOrdiniByUtente(utente.getId_utente());
            }

           
            request.setAttribute("ordini", ordini);

            request.getRequestDispatcher("/WEB-INF/view/Ordine-Clienti.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Errore nel recupero degli ordini: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}