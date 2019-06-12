package student.management;

public class StudentManagement {

    login loginForm;
    QL_User manageUserForm;

    public static void main(String[] args) {

        CONST.loginForm = new login();
        CONST.loginForm.setVisible(true);
    }
}
