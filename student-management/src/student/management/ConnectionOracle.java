/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

import java.sql.*;  

/**
 *
 * @author crazy
 */

public class ConnectionOracle {
    private String userID = "SV001";
    private String lectureID = "LE001";
    private static String user = "DOAN";
    private static String password = "123456";
    private static String connectionObject = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static Connection con;
    public static Connection getConnection(){
        try {
            //Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(connectionObject,user,password); 
           
        } catch ( SQLException e) {
            
            System.out.println(e);
        }
        return con;
    }
    public String getUserID(){
        return userID;
    }
    public String getLectureID(){
        return lectureID;
    }
    public static void main(String[] args) {
        try {
            Connection conn = ConnectionOracle.getConnection();
            CallableStatement procedure = conn.prepareCall("{call test_error}");
            procedure.executeQuery();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
         
        
    }
}
