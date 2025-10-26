package util;
import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/carrental";
    private static final String USER = "postgres";
    private static final String PASSWORD = "1328";
    private static Connection connection;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return connection;
    }
}
