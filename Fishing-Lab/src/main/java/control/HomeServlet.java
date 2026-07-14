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

// La servlet risponde all'indirizzo /home
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // Crea un'istanza del DAO per poter interrogare il database
    private final ProdottoDAO prodottoDAO = new ProdottoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Recupera TUTTI i prodotti dal database tramite il DAO
            List<Prodotto> catalogo = prodottoDAO.doRetrieveAll();
            
            // 2. Salva la lista dei prodotti nella 'request'
            // In questo modo la index.jsp potrà leggerli e visualizzarli nelle card
            request.setAttribute("prodotti", catalogo);
            
        } catch (SQLException e) {
            // 3. Gestione errori: se il database non risponde, passiamo un messaggio di errore alla JSP
            e.printStackTrace();
            request.setAttribute("messaggioErrore", "Errore nel caricamento del catalogo.");
        }

        // 4. Inoltra la richiesta alla pagina JSP (che visualizzerà i prodotti trovati)
        request.getRequestDispatcher("/WEB-INF/view/index.jsp").forward(request, response);
    }
    
    // Il metodo doPost richiama il doGet, così la logica rimane centralizzata 
    // anche se arrivassero dati tramite una richiesta POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}