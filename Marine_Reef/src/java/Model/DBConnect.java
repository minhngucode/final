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
import java.util.Date;

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
        String dbURL = "jdbc:sqlserver://" + ServerName + ";databaseName=" + DBName + ";encrypt=false;trustServerCertificate=false;loginTimeout=30";
        
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
            String sql = "INSERT INTO [User] (Username, Password, CustomerID, role) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pass);
            pstmt.setString(3, newCustomerId);
            pstmt.setString(4, "view");
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
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public static String getCartID(String username, Connection con) {
        String cartID = "";
        try {
            String cusID = getCustomerID(username, con);
            String sql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, cusID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cartID = resultSet.getString("CartID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
   public void addOrder(String orderID, double totalAmount, String customerID, String status) {
    String insertSql = "INSERT INTO Orders (OrderID, OrderDate, TotalAmount, CustomerID, status) VALUES (?, ?, ?, ?, ?)";

    try (
        PreparedStatement insertStmt = getConnection().prepareStatement(insertSql)
    ) {
        // Get the maximum OrderID
      
        
        // Set the parameters for the INSERT statement
        insertStmt.setString(1, orderID);
        insertStmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
        insertStmt.setBigDecimal(3, BigDecimal.valueOf(totalAmount));
        insertStmt.setString(4, customerID);
        insertStmt.setString(5, status);

        // Execute the insert
        insertStmt.executeUpdate();
        System.out.println("Order added successfully with OrderID: " + orderID);
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Failed to add order: " + e.getMessage());
    }
}
   public String newOrderID(){
       int newOrderId = 1;
       try {String selectMaxIdSql = "SELECT MAX(CAST(OrderID AS INT)) FROM Orders";
        PreparedStatement selectMaxIdStmt = getConnection().prepareStatement(selectMaxIdSql);
        ResultSet rs = selectMaxIdStmt.executeQuery();
        if (rs.next()) {
            newOrderId = rs.getInt(1) + 1;
        }
       }
       catch (Exception e){
           
       }
       return String.valueOf(newOrderId);
   }
   public void addOrderDetail( String orderID, String productID, int quantity, double unitPrice) {
        // Câu lệnh SQL để chèn dữ liệu vào bảng OrderDetail
        String query = "INSERT INTO OrderDetail (OrderID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = getConnection().prepareStatement(query)) {
            // Thiết lập các tham số cho PreparedStatement
            statement.setString(1, orderID);
            statement.setString(2, productID);
            statement.setInt(3, quantity);
            statement.setDouble(4, unitPrice);

            // Thực thi câu lệnh SQL
            int rowsAffected = statement.executeUpdate();

            // Kiểm tra kết quả
            if (rowsAffected > 0) {
                System.out.println("Thêm dữ liệu vào OrderDetail thành công.");
            } else {
                System.out.println("Không có dữ liệu nào được thêm vào OrderDetail.");
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ và in thông báo lỗi
            System.out.println("Lỗi khi thêm dữ liệu vào OrderDetail: " + e.getMessage());
        }
    }
   public static double getDiscountPercent( String discountCode, String username) {
        double discountPercent = 0.0;

        String query = "SELECT DiscountPercent FROM DiscountPair WHERE DiscountCode = ? AND username = ?";

        try (PreparedStatement stmt = getConnection().prepareStatement(query)) {
            stmt.setString(1, discountCode);
            stmt.setString(2, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    discountPercent = rs.getDouble("DiscountPercent");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return discountPercent;
    }
     public ArrayList<Order> getOrdersByUsername(String username) {
        ArrayList<Order> orders = new ArrayList<>();
        String query = "SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.CustomerID, o.status " +
                       "FROM orders o " +
                       "JOIN [user] u ON o.CustomerID = u.CustomerID " +
                       "WHERE u.Username = ?";

        try (PreparedStatement preparedStatement = getConnection().prepareStatement(query)) {
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String orderId = resultSet.getString("OrderID");
                Date orderDate = resultSet.getTimestamp("OrderDate");
                BigDecimal totalAmount = resultSet.getBigDecimal("TotalAmount");
                String customerId = resultSet.getString("CustomerID");
                String status = resultSet.getString("status");

                Order order = new Order(orderId, orderDate, totalAmount, customerId, status);
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
     public void deleteOrderFromDatabase(String orderId) {
    String deleteOrderDetailsQuery = "DELETE FROM OrderDetail WHERE OrderID = ?";
    String deleteOrderQuery = "DELETE FROM orders WHERE OrderID = ?";
    Connection con = getConnection();
    try {
        // Bắt đầu transaction
        con.setAutoCommit(false);

        // Xóa các bản ghi trong bảng OrderDetail
        try (PreparedStatement deleteOrderDetailsStmt = con.prepareStatement(deleteOrderDetailsQuery)) {
            deleteOrderDetailsStmt.setString(1, orderId);
            deleteOrderDetailsStmt.executeUpdate();
        }

        // Xóa bản ghi trong bảng orders
        try (PreparedStatement deleteOrderStmt = con.prepareStatement(deleteOrderQuery)) {
            deleteOrderStmt.setString(1, orderId);
            deleteOrderStmt.executeUpdate();
        }

        // Commit transaction
        con.commit();
    } catch (Exception e) {
        try {
            // Rollback transaction nếu có lỗi
            con.rollback();
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
    } finally {
        try {
            // Đặt lại AutoCommit về true
            con.setAutoCommit(true);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    }
   public ArrayList<Order> getAllOrdersSortedByDate() {
    ArrayList<Order> orderList = new ArrayList<>();
    String sql = "SELECT o.*, c.CustomerName FROM Orders o JOIN Customer c ON o.CustomerID = c.CustomerID ORDER BY o.OrderDate DESC"; // Sắp xếp theo ngày đặt hàng, mới nhất đầu tiên
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getString("OrderID"));
            order.setOrderDate(rs.getTimestamp("OrderDate"));
            order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
            order.setCustomerId(rs.getString("CustomerID"));
            order.setCusname(rs.getString("CustomerName")); // Lấy tên khách hàng
            order.setStatus(rs.getString("status"));
            orderList.add(order);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return orderList;
}
    public ArrayList<Order> getOrdersByCustomerNameAndStatus(String customerName, String status) {
    ArrayList<Order> orderList = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT o.*, c.CustomerName FROM Orders o JOIN Customer c ON o.CustomerID = c.CustomerID WHERE 1=1");
    
    // Kiểm tra và thêm điều kiện tìm kiếm theo tên khách hàng nếu có
    if (customerName != null && !customerName.isEmpty()) {
        sql.append(" AND c.CustomerName LIKE ?");
    }
    
    // Kiểm tra và thêm điều kiện lọc theo trạng thái nếu có
    if (status != null && !status.isEmpty()) {
        sql.append(" AND o.status LIKE ?");
    }
    
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
        int paramIndex = 1;
        
        // Gán tham số cho câu lệnh SQL
        if (customerName != null && !customerName.isEmpty()) {
            ps.setString(paramIndex++, "%" + customerName + "%");
        }
        if (status != null && !status.isEmpty()) {
            ps.setString(paramIndex++, "%" + status + "%");
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("OrderID"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                order.setCustomerId(rs.getString("CustomerID"));
                order.setCusname(rs.getString("CustomerName")); // Lấy tên khách hàng
                order.setStatus(rs.getString("status"));
                orderList.add(order);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return orderList;
}
    public boolean updateOrderStatusInDatabase(String orderId, String newStatus) {
    String updateSQL = "UPDATE dbo.Orders SET status = ? WHERE OrderID = ?";
    try (PreparedStatement preparedStatement = getConnection().prepareStatement(updateSQL)) {
        // Đặt các tham số cho câu lệnh SQL
        preparedStatement.setString(1, newStatus);
        preparedStatement.setString(2, orderId);
        
        // Thực thi câu lệnh cập nhật
        int rowsAffected = preparedStatement.executeUpdate();
        
        // Kiểm tra xem có dòng nào được cập nhật không
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace(); // In lỗi ra console để debug
        return false; // Trả về false nếu có lỗi xảy ra
    }
}
    public boolean addShip(String orderId, String customerId, String name, String address, String phone) {
    String insertSQL = "INSERT INTO Shipping (OrderID, CustomerID, Name, Address, Phone) VALUES (?, ?, ?, ?, ?)";
    
    try (PreparedStatement preparedStatement = getConnection().prepareStatement(insertSQL)) {
        // Gán giá trị cho các tham số trong câu lệnh SQL
        preparedStatement.setString(1, orderId);
        preparedStatement.setString(2, customerId);
        preparedStatement.setString(3, name);
        preparedStatement.setString(4, address);
        preparedStatement.setString(5, phone);
        
        // Thực thi câu lệnh SQL
        int rowsAffected = preparedStatement.executeUpdate();
        
        // Kiểm tra xem có bao nhiêu dòng bị ảnh hưởng
        return rowsAffected > 0; // Trả về true nếu thêm thành công, ngược lại trả về false
    } catch (Exception e) {
        e.printStackTrace(); // In lỗi ra console để kiểm tra
        return false; // Trả về false nếu có lỗi xảy ra
    }
    }
    public TransInfo getShippingByOrderId(String orderId) {
    String query = "SELECT OrderID, CustomerID, Name, Address, Phone FROM Shipping WHERE OrderID = ?";
    TransInfo shipping = null;

    try (PreparedStatement preparedStatement = getConnection().prepareStatement(query)) {
        // Gán giá trị cho tham số trong câu lệnh SQL
        preparedStatement.setString(1, orderId);
        
        // Thực thi câu lệnh truy vấn
        ResultSet resultSet = preparedStatement.executeQuery();
        
        // Kiểm tra và lấy thông tin từ ResultSet
        if (resultSet.next()) {
            shipping = new TransInfo();
            shipping.setOrderId(resultSet.getString("OrderID"));
            shipping.setCustomerId(resultSet.getString("CustomerID"));
            shipping.setName(resultSet.getString("Name"));
            shipping.setAddress(resultSet.getString("Address"));
            shipping.setPhone(resultSet.getString("Phone"));
        }
    } catch (Exception e) {
        e.printStackTrace(); // In lỗi ra console để kiểm tra
    }

    return shipping; // Trả về đối tượng Shipping hoặc null nếu không tìm thấy
    
}   
    public ArrayList<OrderDetail> getOrderDetail(String orderId) {
    String query = "SELECT OrderID, ProductID, Quantity, UnitPrice FROM OrderDetail WHERE OrderID = ?";
    ArrayList<OrderDetail> orderDetailList = new ArrayList<>();

    try (PreparedStatement preparedStatement = getConnection().prepareStatement(query)) {
        // Gán giá trị cho tham số trong câu lệnh SQL
        preparedStatement.setString(1, orderId);
        
        // Thực thi câu lệnh truy vấn
        ResultSet resultSet = preparedStatement.executeQuery();
        
        // Duyệt qua kết quả và thêm vào danh sách
        while (resultSet.next()) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderID(resultSet.getString("OrderID"));
            detail.setProductID(resultSet.getString("ProductID"));
            detail.setQuantity(resultSet.getInt("Quantity"));
            detail.setUnitPrice(resultSet.getDouble("UnitPrice"));
            orderDetailList.add(detail);
        }
    } catch (Exception e) {
        e.printStackTrace(); // In lỗi ra console để kiểm tra
    }

    return orderDetailList; // Trả về danh sách chi tiết đơn hàng hoặc danh sách rỗng nếu không có kết quả
}
    public static void main(String[] args) {
        System.out.println(getDiscountPercent("HAPPYNEWYEAR","huan"));
        }
}

