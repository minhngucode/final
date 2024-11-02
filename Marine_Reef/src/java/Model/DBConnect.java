/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
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
    private static ArrayList<CartDetail> arrCart = new ArrayList<>();

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
            e.printStackTrace();
            System.out.println("Error: " + e);
        }
        return con;
    }
    public static boolean signupUser(String name, String pass, String email, String phone, String realname, Connection con) {
        try {

            String selectMaxIdSql = "SELECT MAX(CAST(customerID AS INT)) AS maxID FROM Customer";
            String insertSql = "INSERT INTO Customer (CustomerID, CustomerName, Phone, Email, Address) VALUES (?, ?, ?, ?, ?)";

            // Lấy customerID cao nhất
            String newCustomerId = "1"; // Mặc định là 1 nếu bảng rỗng
            PreparedStatement selectStmt = con.prepareStatement(selectMaxIdSql);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                newCustomerId = String.valueOf(rs.getInt("maxID") + 1); // Tính toán customerID mới
            }
            // Chèn khách hàng mới
            PreparedStatement insertStmt = con.prepareStatement(insertSql);
            insertStmt.setString(1, newCustomerId);
            insertStmt.setString(2, realname);
            insertStmt.setString(3, phone);
            insertStmt.setString(4, email);
            insertStmt.setString(5, " ");
            insertStmt.executeUpdate();
            String sql = "INSERT INTO [User] (Username, Password, CustomerID) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pass);
            pstmt.setString(3, newCustomerId);
            pstmt.executeUpdate();

            String selectMaxCartSql = "SELECT MAX(CAST(CartID AS INT)) AS maxID FROM Cart";
            String cartSql = "INSERT INTO Cart (CartID, CustomerID) VALUES (?, ?)";

            // Lấy customerID cao nhất
            String newCartId = "1"; // Mặc định là 1 nếu bảng rỗng
            PreparedStatement cartstmt = con.prepareStatement(selectMaxCartSql);
            ResultSet rs1 = cartstmt.executeQuery();
            if (rs1.next()) {
                newCartId = String.valueOf(rs1.getInt("maxID") + 1); // Tính toán customerID mới
            }
            // Chèn khách hàng mới
            PreparedStatement insertCartStmt = con.prepareStatement(cartSql);
            insertCartStmt.setString(1, newCartId);
            insertCartStmt.setString(2, newCustomerId);
            insertCartStmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static String getRole(String name){
        String role = null;
        String sql = "SELECT role FROM [User] WHERE Username = ?";

        try (PreparedStatement stmt = getConnection().prepareStatement(sql)) {
            stmt.setString(1, name); // Thiết lập giá trị cho tham số truy vấn
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    role = rs.getString("role"); // Lấy giá trị của cột role
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return role; // Trả v
    }
    public static String getCustomerID(String username, Connection con) {
        String customerID = null;
        try {
            String sql = "SELECT CustomerID FROM [User] WHERE Username = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                customerID = resultSet.getString("CustomerID");
            }

        } catch (Exception e) {
            e.printStackTrace(); // Xử lý lỗi nếu có
        }
        return customerID;
    }
    public static boolean addCartDetail(Product p, String username, int quantity, Connection con) {
        try {
          
            String cartID = getCartID(username, con);
            // Lấy customerID cao nhất
          
            System.out.println("Da den day");
            String cartSql = "MERGE INTO CartDetail AS target " +
                         "USING (VALUES (?, ?, ?)) AS source (CartID, ProductID, Quantity) " +
                         "ON (target.CartID = source.CartID AND target.ProductID = source.ProductID) " +
                         "WHEN MATCHED THEN " +
                         "UPDATE SET target.Quantity = target.Quantity + source.Quantity " +
                         "WHEN NOT MATCHED THEN " +
                         "INSERT (CartID, ProductID, Quantity) " +
                         "VALUES (source.CartID, source.ProductID, source.Quantity);";
            
            PreparedStatement stmt = con.prepareStatement(cartSql);
            stmt.setString(1, cartID);
            stmt.setString(2, p.getProductID());
            stmt.setInt(3, quantity);
            System.out.println(stmt);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Loi add cartdetail");
        }
        return false;
    }
    public static String getCartID(String username, Connection con) {
        String cartID = "";
        try {
            String cusID = getCustomerID(username, con);
                        System.out.println("CusID:"+cusID);

            String sql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, cusID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cartID = resultSet.getString("CartID");
            }
        } catch (Exception e) {
            System.out.println("Loi get cartID");
            e.printStackTrace();
        }
        System.out.println("Con cac:"+cartID);
        return cartID;
    }
    public static ArrayList<CartDetail> getCart(String username, Connection con) {
        try {
            arrCart.clear();
            String cusID = getCustomerID(username, con);
            String cartID = "";
            String sql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, cusID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cartID = resultSet.getString("CartID");
            }
            String detailsql = "SELECT * FROM CartDetail WHERE CartID = ?";
            PreparedStatement stmt = con.prepareStatement(detailsql);
            stmt.setString(1, cartID);
            ResultSet rs = stmt.executeQuery();
            String productID;

            int quantity;
            while (rs.next()) {
                productID = rs.getString("ProductID");
                quantity = rs.getInt("Quantity");
                arrCart.add(new CartDetail(cartID, productID, quantity));
            }
        } catch (Exception e) {
            System.out.println("Loi roi");
            e.printStackTrace();
        }
        return arrCart;
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
            System.out.println(resultSet);
            arrProduct.clear();
            String productID, name, type, description, categoryID;
            BigDecimal price, costPrice;
            int quantity;
            while (resultSet.next()) {
                productID = resultSet.getString("ProductID");
                name = resultSet.getString("Name");
                description = resultSet.getString("Description");
                price = resultSet.getBigDecimal("Price");
                quantity = resultSet.getInt("QuantityInStock");
                categoryID = resultSet.getString("CategoryID");
                costPrice = resultSet.getBigDecimal("CostPrice");
                type = resultSet.getString("Type");
                arrProduct.add(new Product(productID, name, type, description, price, costPrice, quantity, categoryID));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error");
        }
        return arrProduct;
    }
    public static Product getProductbyID(String id, Connection con){
        try {
            String sql = "SELECT * FROM Product WHERE ProductID = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            String productID, name, type, description, categoryID;
            BigDecimal price, costPrice;
            int quantity;
            if (rs.next()) {
                productID = rs.getString("ProductID");
                name = rs.getString("Name");
                description = rs.getString("Description");
                price = rs.getBigDecimal("Price");
                quantity = rs.getInt("QuantityInStock");
                categoryID = rs.getString("CategoryID");
                costPrice = rs.getBigDecimal("CostPrice");
                type = rs.getString("Type");
                return new Product(productID, name, type, description, price, costPrice, quantity, categoryID);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error lay product");
        }
        return null;

    }
    public void updateQuantityCartDetail(String cartID, String productID, int quantity, Connection con) {
    try{
        String query = "UPDATE CartDetail SET Quantity = ? WHERE CartID = ? AND ProductID = ?";
             PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setString(2, cartID);
            ps.setString(3, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Loi update cartdetail");
            e.printStackTrace();
        }
    }
    public void deleteCartDetail(String cartID, String productID, Connection con) {
        try{
        String query = "DELETE FROM CartDetail WHERE CartID = ? AND ProductID = ?";
             PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, cartID);
            ps.setString(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Loi xoa cartdetail");
            e.printStackTrace();
        }
    }
    public CartDetail getCartDetail(String cartID, String productID, Connection conn) {
    CartDetail cartDetail = null;
     try {
    String query = "SELECT * FROM CartDetail WHERE CartID = ? AND ProductID = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, cartID);
        ps.setString(2, productID);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            // Giả sử CartDetail có các thuộc tính là cartID, productID, quantity
            String cID = rs.getString("CartID");
            String pID = rs.getString("ProductID");
            int quantity = rs.getInt("Quantity");
            // Tạo đối tượng CartDetail và trả về
            cartDetail = new CartDetail(cID, pID, quantity);
        }
        
        rs.close();
        ps.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return cartDetail;
}
    public static ArrayList<String> getDistinctTypes(Connection con) {
        ArrayList<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT Type FROM Product";

        try {
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("Type"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return types;
    }
    public ArrayList<Product> getFilteredProducts(String productType, String searchName, BigDecimal minPrice, BigDecimal maxPrice) {
        ArrayList<Product> temp = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Product WHERE 1=1");

        // Điều kiện lọc
        if (productType != null && !productType.isEmpty()) {
            sql.append(" AND Type = ?");
        }
        if (searchName != null && !searchName.isEmpty()) {
            sql.append(" AND Name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND Price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND Price <= ?");
        }
        try{
             PreparedStatement pstmt = getConnection().prepareStatement(sql.toString());
            int index = 1;

            // Thêm giá trị vào các điều kiện lọc
            if (productType != null && !productType.isEmpty()) {
                pstmt.setString(index++, productType);
            }
            if (searchName != null && !searchName.isEmpty()) {
                pstmt.setString(index++, "%" + searchName + "%");
            }
            if (minPrice != null) {
                pstmt.setBigDecimal(index++, minPrice);
            }
            if (maxPrice != null) {
                pstmt.setBigDecimal(index++, maxPrice);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getString("ProductID"));
                product.setName(rs.getString("Name"));
                product.setType(rs.getString("Type"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setCostprice(rs.getBigDecimal("Costprice"));
                product.setQuantityInStock(rs.getInt("QuantityInStock"));
                product.setCategoryID(rs.getString("CategoryID"));
                temp.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return temp;
    }
    public static void addProduct( String name, String description, 
                           BigDecimal price, int quantity, String categoryID, 
                           BigDecimal costPrice, String type) {
        Connection connection = getConnection();
        String sql = "INSERT INTO Product (ProductID, Name, Description, Price, QuantityInStock, CategoryID, CostPrice, Type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            // Thiết lập các tham số cho truy vấn
            preparedStatement.setString(1, generateProductID(connection, categoryID.replaceAll("[0-9]", "")));

            preparedStatement.setString(2, name);
            preparedStatement.setString(3, description);
            preparedStatement.setBigDecimal(4, price);
            preparedStatement.setInt(5, quantity);
            preparedStatement.setString(6, categoryID);
            preparedStatement.setBigDecimal(7, costPrice);
            preparedStatement.setString(8, type);

            // Thực hiện truy vấn
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Sản phẩm đã được thêm thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static String generateProductID(Connection connection, String categoryID) {
         String newProductID = null;
    String sql = "SELECT MAX(TRY_CAST(SUBSTRING(ProductID, LEN(?) + 1, LEN(ProductID)) AS INT)) AS maxID " +
                 "FROM Product WHERE ProductID LIKE ?";

    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        preparedStatement.setString(1, categoryID);
        preparedStatement.setString(2, categoryID + "%");

        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            Integer maxID = resultSet.getInt("maxID");
            if (maxID != null) {
                // Thêm số 0 vào trước maxID để có độ dài ít nhất là 5 ký tự
                String formattedMaxID = String.format("%03d", maxID + 1);
                newProductID = categoryID + formattedMaxID; // Tạo ID mới
            } else {
                // Nếu chưa có sản phẩm nào trong danh mục, bắt đầu từ 00001
                newProductID = categoryID + "00001"; 
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return newProductID;

    }
    public static ArrayList<String> getDistinctCategoryName(Connection con) {
        ArrayList<String> CategoryName = new ArrayList<>();
        String sql = "SELECT DISTINCT CategoryName FROM Category";

        try {
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                CategoryName.add(rs.getString("CategoryName"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return CategoryName;
    }
    public static String getCategoryIDByName( String categoryName) {
        Connection connection = getConnection();
        String categoryID = null;
        String sql = "SELECT categoryID FROM Category WHERE categoryName = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, categoryName);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                categoryID = resultSet.getString("categoryID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryID;
    }
    public static Customer getCustomerDetailsByUsername(String username) {
        String query = "SELECT c.CustomerName, c.Phone, c.Address, c.Email " +
                       "FROM [User] u " +
                       "JOIN Customer c ON u.CustomerID = c.CustomerID " +
                       "WHERE u.Username = ?";
        
        try {
            PreparedStatement ps = getConnection().prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                System.out.println("TIm thay 1 thang");
                Customer customer = new Customer();
                customer.setCustomerName(rs.getString("CustomerName"));
                customer.setPhone(rs.getString("Phone"));
                customer.setEmail(rs.getString("Email"));
                customer.setAddress(rs.getString("Address"));
                return customer;
            }
        }
        catch (Exception e){
            System.out.println("Loi me roi");
      
        } // Trả về null nếu không tìm thấy
        return null;
        
    }
    public static boolean updateCustomer(String username, String customerName, String email, String phone, String address){
        
        try (Connection connection = getConnection()) {
        // Bước 1: Lấy customerID dựa trên username
        String customerID = null;
        String customerIDSQL = "SELECT customerID FROM [User] WHERE username = ?";
        try (PreparedStatement customerIDStatement = connection.prepareStatement(customerIDSQL)) {
            customerIDStatement.setString(1, username);
            try (ResultSet rs = customerIDStatement.executeQuery()) {
                if (rs.next()) {
                    customerID = rs.getString("customerID");
                }
            }
        }

        // Kiểm tra nếu customerID được tìm thấy
        if (customerID != null) {
            // Bước 2: Cập nhật thông tin trong bảng Customer
            String updateSQL = "UPDATE Customer SET CustomerName = ?, Email = ?, Phone = ?, Address = ? WHERE customerID = ?";
            try (PreparedStatement updateStatement = connection.prepareStatement(updateSQL)) {
                updateStatement.setString(1, customerName);
                updateStatement.setString(2, email);
                updateStatement.setString(3, phone);
                updateStatement.setString(4, address);
                updateStatement.setString(5, customerID); // Sử dụng customerID để xác định bản ghi cần cập nhật

                // Thực hiện cập nhật
                int rowsAffected = updateStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Cập nhật thành công
                    return true;
                } else {
                    // Không tìm thấy bản ghi
                    return false;
                }
            }
        } else {
            // Không tìm thấy customerID tương ứng với username
            return false;
        }
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
    }
//    public static void main(String[] args) {
//        System.out.println(updateCustomer("huan", "Nguyễn Văn Huân", "huan@fpt.vn", "0345997792", "12/9 cách mạng"));
//        }
}

