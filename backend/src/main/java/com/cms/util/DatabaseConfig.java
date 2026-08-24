package com.cms.util;

public class DatabaseConfig{
    private static final String DB_URL = System.getenv("CMS_DB_URL");
    private static final String DB_USERNAME = System.getenv("CMS_DB_USERNAME");
    private static final String DB_PASSWORD = System.getenv("CMS_DB_PASSWORD");

     public static String getUrl() {
        return DB_URL;
    }

    public static String getUsername() {
        return DB_USERNAME;
    }

    public static String getPassword() {
        return DB_PASSWORD;
    }
}