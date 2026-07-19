package dao;

import model.Ordine;
import model.Prodotto;
import java.sql.*;
import util.DataSourceConnection; 

public class OrdineDAO {

    // CORRETTO: il parametro deve essere di tipo model.Ordine
    public int inserisciOrdine(Ordine o) throws SQLException {
        String sql = "INSERT INTO ordine (id_utente, totale, indirizzo, data_ordine) VALUES (?, ?, ?, NOW())";
        
        try (Connection con = DataSourceConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            // Assicurati che questi metodi (getIdUtente, getTotale, getIndirizzo) 
            // esistano esattamente così nella tua classe model.Ordine
            ps.setInt(1, o.getIdUtente());
            ps.setDouble(2, o.getTotale());
            ps.setString(3, o.getIndirizzo());
            
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    // Aggiungi questo metodo per salvare il dettaglio ordine
    public void inserisciDettaglio(int idOrdine, Prodotto p) throws SQLException {
        String sql = "INSERT INTO dettaglio_ordine (id_ordine, id_prodotto, prezzo) VALUES (?, ?, ?)";
        
        try (Connection con = DataSourceConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idOrdine);
            ps.setInt(2, p.getId_prodotto());
            ps.setDouble(3, p.getPrezzo());
            
            ps.executeUpdate();
        }
    }
}