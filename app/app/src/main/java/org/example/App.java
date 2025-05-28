package org.example;

import java.sql.*;

public class App {
    public String getGreeting() {
        return "Hello World!!";
    }

    // VULNERABLE METHOD ADDED
    public static void getUser(String username) {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test");
            Statement stmt = conn.createStatement();
            
            // UNSAFE SQL CONCATENATION - CRITICAL VULNERABILITY
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE name = '" + username + "'");
            
            while (rs.next()) {
                System.out.println(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println(new App().getGreeting());
        getUser(args.length > 0 ? args[0] : "admin"); // USER-CONTROLLED INPUT
    }
}
