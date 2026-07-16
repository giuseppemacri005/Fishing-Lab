package dao;

import java.sql.*;
import util.DataSourceConnection; // Cambia 'util' col pacchetto corretto dove si trova la tua classe
import model.Utente;
public class UtenteDAO {
	
	public Utente login(String email, String password) {
	    System.out.println("DEBUG DAO: Cerco utente con email: " + email + " e password: " + password);
	    
	    try (Connection conn = DataSourceConnection.getConnection()) {
	        String sql = "SELECT * FROM utente WHERE email = ? AND password = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, email);
	        ps.setString(2, password);
	        
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            System.out.println("DEBUG DAO: Utente trovato! Nome nel DB: " + rs.getString("nome"));
	            Utente u = new Utente();
	            u.setNome(rs.getString("nome"));
	            u.setEmail(rs.getString("email"));
	            return u;
	        } else {
	            System.out.println("DEBUG DAO: Nessun utente trovato con queste credenziali.");
	        }
	    } catch (SQLException e) {
	        System.out.println("DEBUG DAO: Errore SQL!");
	        e.printStackTrace();
	    }
	    return null;
	}}