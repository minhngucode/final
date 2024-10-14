/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import Model.Book;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;

/**
 *
 * @author
 */
public class DBConnect {
    static ArrayList<Book> listBook = new ArrayList<>();
    public static Connection getConnection() {
        Connection con = null;
        String dbUser = "sa";
        String dbPassword = "admin";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "minipele";
        String DBName = "Books_DE180362";
        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        String dbURL = "jdbc:sqlserver://minipele;databaseName=Books_DE180362;encrypt=false;trustServerCertificate=false;loginTimeout=30";

        try {
            Class.forName(driverClass);
            //DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            con = (Connection) DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return con;
    }
    
    public static ArrayList<Book> getAll(){
        try{
        Connection connection = getConnection();
        String sql = "SELECT * FROM Books";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        listBook.clear();
        while (resultSet.next()) {
               int id = resultSet.getInt("id");
               String title = resultSet.getString("title");
               String author = resultSet.getString("author");
               Date dop = resultSet.getDate("publication_date");
               int quantity = resultSet.getInt("quantity");
               //System.out.println(id +" "+ ten+" "+ mau +" "+ gia);
               listBook.add(new Book(id, title, author, dop, quantity));
            }
        } catch (Exception e){
            listBook=null;
        }   
        return listBook;
    }
    public static boolean checkLogininfo(String username, String password){
        try{
        Hash ec = new Hash();
        Connection connection = getConnection();
        String sql = "SELECT * FROM logininfo";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
               String tk = resultSet.getString("username");
               String mk = resultSet.getString("pass");
               if (username.equals(tk))
                   if (ec.encryptPassword(password).equals(mk))
                       return true;
                    else
                       return false;
               
            }
        } catch (Exception e){
            return false;
        }   
        return false;

    }
    public static boolean addDB(int id, String titlte, String author,  String dop, int quantity){
        try{
        Connection connection = getConnection();
        String sqlInsert = "INSERT INTO Books (id, title, author, publication_date, quantity) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sqlInsert);
        statement.setInt(1, id);
        statement.setString(2, titlte);
        statement.setString(3, author);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date format = sdf.parse(dop);
         Date sqlDate = new Date(format.getTime());
        statement.setDate(4, sqlDate);
        statement.setInt(5, quantity);
        statement.executeUpdate();
        statement.close();
        return true;
        }
        catch (Exception e){
            return false;
        }
    }
    public static boolean deleteDB(int id){
        try{
        Connection connection = getConnection();
        java.sql.Statement statement = connection.createStatement();
        String sqlDelete = "DELETE FROM Books WHERE ID = " + id;
        statement.executeUpdate(sqlDelete);
        return true;
        }
        catch (Exception e){
            return false;
        }
    }
    public static boolean updateDB(int id, String titlte, String author,  String dop, int quantity){
        try{
            Connection connection = getConnection();

            String sqlQuery="UPDATE Coral SET Name=?, Color=?, Price=? WHERE ID="+id;
            PreparedStatement stmt = connection.prepareStatement(sqlQuery);
            stmt.setString(1, titlte);
            stmt.setString(2, author);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date format = sdf.parse(dop);
         Date sqlDate = new Date(format.getTime());
        stmt.setDate(4, sqlDate);
            stmt.setInt(5, quantity);
            stmt.execute();
            stmt.close();
            return true;
                }
        catch (Exception e){
            return false;
        }
    }
   

    public static ArrayList<Book> getBooksOverdue(String last) {
        ArrayList<Book> overdueBooks = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Kết nối với cơ sở dữ liệu
            connection = getConnection();
            
            // Truy vấn SQL để lấy các sách quá hạn
            String sql = "SELECT b.id, b.title, b.author, b.publication_date, b.quantity " +
                         "FROM Books b JOIN Loans l ON b.id = l.book_id WHERE l.return_date < ?";
            
            // Chuẩn bị truy vấn với giá trị của date
            preparedStatement = connection.prepareStatement(sql);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            java.util.Date format = sdf.parse(last);
            Date sqlDate = new Date(format.getTime());
     
            preparedStatement.setDate(1, sqlDate);
            
            // Thực thi truy vấn
            resultSet = preparedStatement.executeQuery();
            
            // Thêm các sách quá hạn vào danh sách
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String author = resultSet.getString("author");
                Date publicationDate = resultSet.getDate("publication_date");
                int quantity = resultSet.getInt("quantity");

                // Tạo đối tượng Book và thêm vào danh sách
                Book book = new Book(id, title, author, publicationDate, quantity);
                overdueBooks.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng các kết nối và tài nguyên
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return overdueBooks;
    }
    
    
//    public static void main(String[] args) {
//        ArrayList<Book> arr = new ArrayList<>();
//        arr=getBooksOverdue("2024-09-12");
//        for (Book x: arr){
//            System.out.println(x);
//        }
//    }
        
}
