/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class User {
    private String userName;   // Tên người dùng
    private String password;   // Mật khẩu
    private String cusID;      // Mã khách hàng

    // Constructor
    public User(String userName, String password, String cusID) {
        this.userName = userName;
        this.password = password;
        this.cusID = cusID;
    }

    // Getters and Setters
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }
}

