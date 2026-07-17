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

    public Prodotto doRetrieveByKey(int id) { // Cambiato da String a int
        // Cambiato 'id' in 'id_prodotto' per corrispondere al database
        List<Prodotto> res = eseguiQuery("SELECT * FROM prodotto WHERE id_prodotto = ?", String.valueOf(id));
        return res.isEmpty() ? null : res.get(0);
    }
    public List<Prodotto> doSearch(String nome, String categoria) {
        List<Prodotto> lista = new ArrayList<>();
        String sql = "SELECT * FROM prodotto WHERE 1=1"; // 1=1 facilita l'aggiunta di clausole
        
        if (nome != null && !nome.isEmpty()) sql += " AND nome_prodotto LIKE ?";
        if (categoria != null && !categoria.equals("Tutte")) sql += " AND categoria = ?";

        try (Connection con = DataSourceConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            int i = 1;
            if (nome != null && !nome.isEmpty()) ps.setString(i++, "%" + nome + "%");
            if (categoria != null && !categoria.equals("Tutte")) ps.setString(i++, categoria);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId_prodotto(rs.getInt("id_prodotto"));
                    p.setNome_prodotto(rs.getString("nome_prodotto"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setImmagine(rs.getString("immagine"));
                    lista.add(p);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    private List<Prodotto> eseguiQuery(String sql, String param) {
        List<Prodotto> lista = new ArrayList<>();
        // Il try-with-resources chiude automaticamente la connessione restituita dal DataSource
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            if (param != null) ps.setString(1, param);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prodotto p = new Prodotto();
                    p.setId_prodotto(rs.getInt("id_prodotto"));
                    p.setNome_prodotto(rs.getString("nome_prodotto"));
                    p.setDescrizione(rs.getString("descrizione"));
                    p.setPrezzo(rs.getDouble("prezzo"));
                    p.setImmagine(rs.getString("immagine"));
                    p.setCategoria(rs.getString("categoria"));
                    lista.add(p);
                }
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return lista;
    }
}