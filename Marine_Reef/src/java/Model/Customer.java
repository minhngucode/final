/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class Customer {
    private String cusID;      // ID của khách hàng
    private String cusName;    // Tên khách hàng
    private String phone;      // Số điện thoại
    private String email;      // Địa chỉ email
    private String address;    // Địa chỉ

    // Constructor
    public Customer(String cusID, String cusName, String phone, String email, String address) {
        this.cusID = cusID;
        this.cusName = cusName;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }   

    public Customer() {
    }
    
    // Getters and Setters
    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

