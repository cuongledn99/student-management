/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

/**
 *
 * @author crazy
 */
import java.util.HashMap;
import java.util.Map;
import java.sql.*;

public class StudentManagement {

    login loginForm;
    QL_User manageUserForm;

    public static void main(String[] args) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Windows".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(DangKyHP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(DangKyHP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(DangKyHP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(DangKyHP.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

//        Map<String, String> data = new HashMap<String, String>();
//        data.put("username", "cuongledn99");
//        data.put("password", "cuong123");
       //String res = HttpRequest.post("http://localhost:3000/api").form(data).body();
        //System.out.println("Response was: " + res);
        CONST.loginForm = new login();
        CONST.loginForm.setVisible(true);
//        Gson gson = new Gson();
//        //User[] a = gson.fromJson(HttpRequest.get("http://localhost:3000/api/i/it").body(), User[].class);
//        User loginAPIResponse =gson.fromJson(HttpRequest.post("http://localhost:3000/api").form(data).body(), User.class);
//        //System.out.println("asdf: " + loginAPIResponse.fullname);
//        loginAPIResponse.showInfo();
        
    }
}

