package student.management;

import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;
import java.sql.*;

public class StudentManagement {

    login loginForm;
    QL_User manageUserForm;

    public static void main(String[] args) {
        

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
