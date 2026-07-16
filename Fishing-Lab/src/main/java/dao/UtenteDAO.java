package dao;

import java.sql.*;
import util.DataSourceConnection; // Cambia 'util' col pacchetto corretto dove si trova la tua classe
import model.Utente;
public class UtenteDAO {
    
    public Utente login(String email, String password) {
        // Usiamo la tua classe di connessione
        try (Connection conn = DataSourceConnection.getConnection()) {
            String sql = "SELECT * FROM utente WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Utente u = new Utente();
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                // u.setId(rs.getInt("id_utente")); // Scommenta se hai anche l'ID nel model
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}