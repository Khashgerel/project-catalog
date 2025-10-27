package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
    private static String dbUrl;

    public static void configure(String absoluteDbPath) {
        dbUrl = "jdbc:sqlite:" + absoluteDbPath;
    }

    public static Connection get() throws SQLException {
        return DriverManager.getConnection(dbUrl);
    }
}

