package util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DataSourceConnection {
    private static DataSource dataSource;

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            try {
                Context initContext = new InitialContext();
                Context envContext = (Context) initContext.lookup("java:comp/env");
                dataSource = (DataSource) envContext.lookup("jdbc/fishing-lab-db");
            } catch (Exception e) {
                throw new SQLException("Errore nel recupero del DataSource dal Context", e);
            }
        }
        return dataSource.getConnection();
    }
}