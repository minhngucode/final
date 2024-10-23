/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author
 */
public class DBConnect {

    private static ArrayList<Product> arrProduct = new ArrayList<>();
    private static ArrayList<User> arrUser = new ArrayList<>();

    public static Connection getConnection() {
        Connection con = null;
        String dbUser = "sa";
        String dbPassword = "minh280504";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "MINHDC";
        String DBName = "SalesWebsite";
        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        String dbURL = "jdbc:sqlserver://minipele;databaseName=SalesWebsite;encrypt=false;trustServerCertificate=false;loginTimeout=30";

        try {
            Class.forName(driverClass);
            //DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            con = (Connection) DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return con;
    }

    public static ArrayList<User> getUser(Connection con) {
        try {
            String sql = "SELECT * FROM [User]";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            String name, pass, id;
            arrUser.clear();
            while (resultSet.next()) {
                name = resultSet.getString("Username");
                pass = resultSet.getString("Password");
                id = resultSet.getString("CustomerID");
                arrUser.add(new User(name,pass,id));
            }
        } catch (Exception e) {
            System.out.println("Loi get User");
            e.printStackTrace();
        }
        return arrUser;
    }

    public static ArrayList<Product> getProduct(Connection con) {
        try {
            String sql = "SELECT * FROM Product";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            arrProduct.clear();
            String productID, name, id, type, color, description, categoryID;
            double price, costPrice;
            int quantity;
            while (resultSet.next()) {
                productID = resultSet.getString("ProductID");
                name = resultSet.getString("Name");
                type = resultSet.getString("Type");
                description = resultSet.getString("Description");
                price = resultSet.getDouble("Price");
                costPrice = resultSet.getDouble("CostPrice");
                quantity = resultSet.getInt("Quantity");
                categoryID = resultSet.getString("CategoryID");
                arrProduct.add(new Product(productID, name, type, description, price, costPrice, quantity, categoryID));
            }
        } catch (Exception e) {
            System.out.println("Error");
        }
        return arrProduct;
    }

    public static void main(String[] args) {
        Connection con = getConnection();
        System.out.println(getProduct(con));
    }
    
}
