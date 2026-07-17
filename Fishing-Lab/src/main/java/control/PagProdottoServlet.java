package control;

import model.Prodotto;
import dao.ProdottoDAO; // Assumi di avere un DAO per i prodotti
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ProdottoServlet")
public class PagProdottoServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
        	// Nella tua ProdottoServlet
        	int id = Integer.parseInt(request.getParameter("id"));

        	ProdottoDAO pDao = new ProdottoDAO();
        	Prodotto p = pDao.doRetrieveByKey(id); // Usa il nome corretto del metodo

            if (p != null) {
                request.setAttribute("prodotto", p);
                request.getRequestDispatcher("/WEB-INF/view/PagProdotto.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}