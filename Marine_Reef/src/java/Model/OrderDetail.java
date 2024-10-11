/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class OrderDetail {
    private String orderDetailID;  // Mã chi tiết đơn hàng
    private String orderID;        // Mã đơn hàng
    private String productID;      // Mã sản phẩm
    private int quantity;          // Số lượng sản phẩm
    private String discountCode;   // Mã giảm giá

    // Constructor
    public OrderDetail(String orderDetailID, String orderID, String productID, int quantity, String discountCode) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.discountCode = discountCode;
    }

    public OrderDetail() {
    }
    
    // Getters and Setters
    public String getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(String orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }
}

