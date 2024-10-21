/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class CartDetail {
     private String cartDetailID;
    private String cartID;
    private String productID;
    private int quantity;

    public CartDetail(String cartDetailID, String cartID, String productID, int quantity) {
        this.cartDetailID = cartDetailID;
        this.cartID = cartID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public String getCartDetailID() {
        return cartDetailID;
    }

    public void setCartDetailID(String cartDetailID) {
        this.cartDetailID = cartDetailID;
    }

    public String getCartID() {
        return cartID;
    }

    public void setCartID(String cartID) {
        this.cartID = cartID;
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
    
}
