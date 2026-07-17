package dao;

import java.sql.*;
import util.DataSourceConnection;
import model.Prodotto;

public class DettaglioOrdineDAO {

    public void inserisciDettaglio(int idOrdine, Prodotto p) {
        String sql = "INSERT INTO dettaglio_ordine (id_ordine, id_prodotto, prezzo) VALUES (?, ?, ?)";
        
        try (Connection con = DataSourceConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idOrdine);
            ps.setInt(2, p.getId_prodotto());
            ps.setDouble(3, p.getPrezzo());
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}