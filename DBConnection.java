package com.smartdesk.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    Connection con;

    public Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/smartdesk",
                "root",
                "YOUR_DB_PASSWORD"
            );

        } catch (Exception e) {

            e.printStackTrace();

        }

        return con;
    }
}