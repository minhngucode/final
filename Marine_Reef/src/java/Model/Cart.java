/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
import java.util.Date;

public class Cart {
    private String orderID;    // Mã đơn hàng
    private String cusID;      // Mã khách hàng
    private Date orderDate;    // Ngày đặt hàng

    // Constructor
    public Cart(String orderID, String cusID, Date orderDate) {
        this.orderID = orderID;
        this.cusID = cusID;
        this.orderDate = orderDate;
    }

    public Cart() {
    }
    
    // Getters and Setters
    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getCusID() {
        return cusID;
    }

    public void setCusID(String cusID) {
        this.cusID = cusID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}

