/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

import java.sql.*;

/**
 *
 * @author Huy Cuong
 */
public class DBConnection {

    public static  Connection con;
    private String username;
    private String password;
    private String hostname;
    private String port;
    private String DBName;
    public DBConnection(){
        hostname="localhost";
        username="root";
        password="";
        port="3306";
        DBName="test";
    }
    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connectionString = "jdbc:mysql://" + hostname + ":" + port + "/" + DBName;
            System.out.println(connectionString);
            con = DriverManager.getConnection(connectionString, username, password);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void disconnect() {
        try {
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public ResultSet query(String query) {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            return rs;
        } catch (Exception e) {
            System.out.println("error in query function");
             System.out.println(e);
            return null;
        }

        
    }
}
