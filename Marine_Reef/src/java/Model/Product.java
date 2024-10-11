/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author
 */
public class Product {
    private String name;        // Tên sản phẩm
    private String id;          // ID sản phẩm
    private String type;        // Loài: Skimmer, SPS, LPS, Soft, Pump, Filter, Light, Tank
    private String color;       // Màu sắc: Full color
    private String description; // Mô tả sản phẩm
    private double price;       // Giá bán: VNĐ
    private double costPrice;   // Giá nhập: VNĐ
    private int quantity;       // Số lượng: Unit/Frag

    // Constructor
    public Product(String name, String id, String type, String color, String description, double price, double costPrice, int quantity) {
        this.name = name;
        this.id = id;
        this.type = type;
        this.color = color;
        this.description = description;
        this.price = price;
        this.costPrice = costPrice;
        this.quantity = quantity;
    }

    public Product() {
    }
    

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Product{" + "name=" + name + ", id=" + id + ", type=" + type + ", color=" + color + ", description=" + description + ", price=" + price + ", costPrice=" + costPrice + ", quantity=" + quantity + '}';
    }
    
}
