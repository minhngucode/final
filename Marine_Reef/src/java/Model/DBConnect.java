/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.PreparedStatement;
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
        String dbPassword = "admin";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "minipele";
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

    public static boolean signupUser(String name, String pass, String email, String phone, Connection con) {
        try {
            

            String selectMaxIdSql = "SELECT MAX(CAST(customerID AS INT)) AS maxID FROM Customer";
            String insertSql = "INSERT INTO Customer (CustomerID, CustomerName, Phone, Email, Address) VALUES (?, ?, ?, ?, ?)";

            // Lấy customerID cao nhất
            String newCustomerId="null"; // Mặc định là 1 nếu bảng rỗng
            PreparedStatement selectStmt = con.prepareStatement(selectMaxIdSql);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                newCustomerId = String.valueOf(rs.getInt("maxID") + 1) ; // Tính toán customerID mới
            }
            // Chèn khách hàng mới
            PreparedStatement insertStmt = con.prepareStatement(insertSql);
            insertStmt.setString(1, newCustomerId);
            insertStmt.setString(2, " ");
            insertStmt.setString(3, " ");
            insertStmt.setString(4, " ");
            insertStmt.setString(5, " ");
            insertStmt.executeUpdate();
            String sql = "INSERT INTO [User] (Username, Password, CustomerID) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pass);
            pstmt.setString(3, newCustomerId );
                        System.out.println("name"+name+"pass"+pass+"id"+newCustomerId);

                                    System.out.println("Da toi day");

            pstmt.executeUpdate();
                                    System.out.println("Da toi day");

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;

        }
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
                arrUser.add(new User(name, pass, id));
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
