/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

public class StudentManagement {

    login loginForm;
    QL_User manageUserForm;

    public static void main(String[] args) {

        CONST.loginForm = new login();
        CONST.loginForm.setVisible(true);
    }
}

