package dao;

import java.sql.*;
import util.DataSourceConnection; 
import model.Utente;

public class UtenteDAO {
    
    public boolean registra(Utente u) {
        String sql = "INSERT INTO utente (nome, cognome, email, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DataSourceConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, u.getNome());
            ps.setString(2, u.getCognome());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Utente login(String email, String password) {
        String sql = "SELECT * FROM utente WHERE email = ? AND password = ?";
        try (Connection conn = DataSourceConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Utente u = new Utente();
                    u.setId_utente(rs.getInt("id_utente"));
                    u.setNome(rs.getString("nome"));
                    u.setCognome(rs.getString("cognome"));
                    u.setEmail(rs.getString("email"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}