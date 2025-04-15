package dao;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.mysql.cj.jdbc.MysqlConnectionPoolDataSource;
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/library_db";
    private static final String USER = "root";
    private static final String PASSWORD = "Vikas@9156";
    
    // Use connection pooling instead of single connection
    private static DataSource dataSource;
    
    static {
        try {
            MysqlConnectionPoolDataSource pool = new MysqlConnectionPoolDataSource();
            pool.setUrl(URL);
            pool.setUser(USER);
            pool.setPassword(PASSWORD);
            dataSource = pool;
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}