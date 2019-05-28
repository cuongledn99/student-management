/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huy Cuong
 */
class OraConnection {

    public static Connection openConnection(
            String db_host_name,
            String db_port,
            String db_service_name,
            String db_username,
            String db_password
    ) throws SQLException {
        String connection_string = String.format(
                "%s:%s:%s:@%s:%s/%s",
                "jdbc",
                "oracle",
                "thin",
                db_host_name,
                db_port,
                db_service_name
        );

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OraConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

        return DriverManager.getConnection(
                connection_string,
                db_username,
                db_password
        );
    }
}

public class DBConnection {

    String db_host_name;
    String db_port;
    String db_service_name;
    String db_username;
    String db_password;
    public static Connection con;

    public void connect() {
        try {
            con = OraConnection.openConnection(CONST.hostname, CONST.port, CONST.dbname, CONST.username, CONST.password);
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void disconnect() {
        try {
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public ResultSet query(String query) {

        try {

            PreparedStatement sql = DBConnection.con.prepareStatement(query);
            ResultSet result = sql.executeQuery();
            return result;

        } catch (Exception e) {
            System.out.println(e);
        }

        return null;
    }

    

}
