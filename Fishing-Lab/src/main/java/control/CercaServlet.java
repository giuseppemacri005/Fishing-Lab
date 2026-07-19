package control; 

import java.io.IOException;
import java.util.List;
import model.Prodotto;
import dao.ProdottoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CercaServlet")
public class CercaServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
      
        String query = request.getParameter("ricerca"); 
      
        
        ProdottoDAO dao = new ProdottoDAO();
        
        try {
         
            List<Prodotto> risultati = dao.doSearch(query);
            
          
            request.setAttribute("prodotti", risultati);
            
        
            request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}