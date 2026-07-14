package dao;

import java.sql.*;
import java.util.*;
import model.Prodotto;
import util.DataSourceConnection; // Importa la tua classe di utilità

public class ProdottoDAO {

    // Recupera la connessione tramite la tua classe util
    private Connection getConnection() throws SQLException {
        return DataSourceConnection.getConnection();
    }

    public List<Prodotto> doRetrieveAll() throws SQLException {
        return eseguiQuery("SELECT * FROM prodotto", null);
    }

    public Prodotto doRetrieveByKey(String id) {
        List<Prodotto> res = eseguiQuery("SELECT * FROM prodotto WHERE id = ?", id);
        return res.isEmpty() ? null : res.get(0);
    }

    private List<Prodotto> eseguiQuery(String sql, String param) {
        List<Prodotto> lista = new ArrayList<>();
        // Il try-with-resources chiude automaticamente la connessione restituita dal DataSource
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            if (param != null) ps.setString(1, param);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId_prodotto(rs.getInt("id"));
                    p.setNome_prodotto(rs.getString("nome"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setImmagine(rs.getString("immagine"));
                    lista.add(p);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return lista;
    }
}