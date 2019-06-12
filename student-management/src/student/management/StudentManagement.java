package student.management;

import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import java.sql.*;

public class StudentManagement {

    login loginForm;
    QL_User manageUserForm;

    public static void main(String[] args) {


        

         CONST.loginForm = new login(); 
         CONST.loginForm.setVisible(true);
    }
}
