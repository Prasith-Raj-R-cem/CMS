package com.cms.testfiles;

import java.sql.Connection;

import com.cms.util.DatabaseConnection;

public class TestDatabaseConnection{
    public static void main(String[] args) {
        try (Connection connection = DatabaseConnection.getConnection()) {
            System.out.println("Database connected successfully"); 
        } catch (Exception e) {
            System.out.println("Database connection failed");
            e.printStackTrace();
        }
    }
}

// ================================================ TESTING =======================================================================

// This code section is for testing purpose only.This code is used to know the connection of db.

//=================================================================================================================================