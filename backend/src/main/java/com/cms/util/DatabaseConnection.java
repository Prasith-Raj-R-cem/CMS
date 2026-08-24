package com.cms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    public static Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println(
                    "MySQL JDBC Driver loaded successfully"
            );

        } catch (ClassNotFoundException e) {

            System.out.println(
                    "MySQL JDBC Driver NOT FOUND"
            );

            throw new SQLException(
                    "MySQL JDBC Driver not found",
                    e
            );
        }

        return DriverManager.getConnection(
                DatabaseConfig.getUrl(),
                DatabaseConfig.getUsername(),
                DatabaseConfig.getPassword()
        );
    }
}