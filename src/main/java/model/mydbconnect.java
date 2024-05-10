package model;

import java.sql.*;

public class mydbconnect {
    static final String MYSQL_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String MYSQL_URL = "jdbc:mysql://localhost:3306/familyconnect";
    static final String MYSQL_USER = "root";
    static final String MYSQL_PASSWORD = "dlwkddn234";

    public mydbconnect() {
        try {
            Class.forName(MYSQL_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public Connection getConnection() throws SQLException {
        Connection conn = null;
        conn = DriverManager.getConnection(MYSQL_URL, MYSQL_USER, MYSQL_PASSWORD);

        return conn;
    }

    public void dbClose(Connection conn, Statement stmt, ResultSet rs) throws SQLException,NullPointerException {
        conn.close();
        stmt.close();
        rs.close();
    }

    public void dbClose(Connection conn, Statement stmt) throws SQLException,NullPointerException {
        conn.close();
        stmt.close();
    }
}
