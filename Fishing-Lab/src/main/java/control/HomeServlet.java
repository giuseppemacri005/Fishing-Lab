package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final ProdottoDAO prodottoDAO = new ProdottoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            
            List<Prodotto> catalogo = prodottoDAO.doRetrieveAll();
            
            
            request.setAttribute("prodotti", catalogo);
            
        } catch (SQLException e) {
            
            e.printStackTrace();
            request.setAttribute("messaggioErrore", "Errore nel caricamento del catalogo.");
        }

        
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}