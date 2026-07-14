package util;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataSourceConnection {

    private static BasicDataSource dataSource;

    static {
        dataSource = new BasicDataSource();
        
        // Configurazione del driver e del database
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/fishing-lab-db?useSSL=false&serverTimezone=UTC");
        dataSource.setUsername("root");
        dataSource.setPassword("Sonogiuseppe2005.");

        // Configurazione del Pool
        dataSource.setMinIdle(5);       // Connessioni minime sempre pronte
        dataSource.setMaxIdle(10);      // Connessioni massime in attesa
        dataSource.setMaxTotal(25);     // Numero massimo totale di connessioni
    }

    // Metodo per ottenere la connessione
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}