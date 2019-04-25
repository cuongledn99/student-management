/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student.management;

/**
 *
 * @author Huy Cuong
 */
public class User {

    public String _id;
    public String username;
    public String fullname;
    public String roles;
    public String email;
    public String dateofbirth;
    public String address;
    public String phone;
    public int __v;
    public User(){
        
    }
    public void showInfo(){
        System.out.println("id: "+_id);
        System.out.println("username: "+username);
        System.out.println("fullname: "+fullname);
    }
}
