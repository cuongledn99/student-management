
package student.management;


import java.util.HashMap;
import java.util.Map;

public class StudentManagement {

    public static void main(String[] args) {
        Map<String, String> data = new HashMap<String, String>();
        data.put("username", "cuongledn99");
        data.put("password", "cuong123");
        String res = HttpRequest.post("http://localhost:3000/api").form(data).body();
        System.out.println("Response was: " + res);
    }
}
