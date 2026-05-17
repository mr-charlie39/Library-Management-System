package com.lms.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	private static final String url = "jdbc:mysql://127.0.0.1:3306/library_db?useSSL=false&allowPublicKeyRetrieval=true";
	private static final String username = "root";
	private static final String password = "mali3187";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(url, username, password);
    }
}