package control;

import model.Prodotto;
import dao.ProdottoDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CercaServlet")
public class CercaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
       
        String query = request.getParameter("ricerca"); 
        String categoria = request.getParameter("categoria");

      
        ProdottoDAO pDao = new ProdottoDAO();
        List<Prodotto> risultati = pDao.doSearch(query, categoria);

      
        request.setAttribute("prodotti", risultati);

     
        request.getRequestDispatcher("/home").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}