package dao;

import java.sql.*;
import util.DataSourceConnection; 

public class OrdineDAO {

    public int inserisciOrdine(int idUtente, double totale) {
        int idGenerato = -1;
        String sql = "INSERT INTO ordine (id_utente, data_ordine, totale) VALUES (?, NOW(), ?)";
        
        // Il try-with-resources apre e chiude la connessione automaticamente
        try (Connection con =DataSourceConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, idUtente);
            ps.setDouble(2, totale);
            ps.executeUpdate();
            
            // Recupera l'ID autoincrementale generato dal database
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    idGenerato = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Utile per vedere errori in console
        }
        return idGenerato;
    }
}