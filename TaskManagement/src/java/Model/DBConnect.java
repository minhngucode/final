/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
/**
 *
 * @author
 */
public class DBConnect {    
    ArrayList<Tasks> arrTask = new ArrayList<>();
    ArrayList<Users> arrUser = new ArrayList<>();
    ArrayList<TaskAssignments> arrTaskAss = new ArrayList<>();
    public static Connection getConnection() {
        Connection con = null;
        String dbUser = "sa";
        String dbPassword = "admin";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "minipele";
        String DBName = "SalesWebsite";
        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        String dbURL = "jdbc:sqlserver://minipele;databaseName=TaskManagement;encrypt=false;trustServerCertificate=false;loginTimeout=30";

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
    public static ArrayList<Users> getAllUsers() {
        ArrayList<Users> users = new ArrayList<>();
        String query = "SELECT user_id, username, email, password, registration_date FROM Users";

        try (PreparedStatement statement = getConnection().prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                String password = resultSet.getString("password");
                Date registrationDate = resultSet.getDate("registration_date");

                Users user = new Users(userId, username, email, password, registrationDate);
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
    public static ArrayList<Tasks> getTasksByUsername(String username) {
        ArrayList<Tasks> tasks = new ArrayList<>();
        String query = "SELECT t.task_id, t.title, t.description, t.created_date, t.due_date, t.status " +
                       "FROM Tasks t " +
                       "JOIN TaskAssignments ta ON t.task_id = ta.task_id " +
                       "JOIN Users u ON ta.user_id = u.user_id " +
                       "WHERE u.username = ?";

        try (PreparedStatement statement = getConnection().prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    int taskId = resultSet.getInt("task_id");
                    String title = resultSet.getString("title");
                    String description = resultSet.getString("description");
                    Date createdDate = resultSet.getDate("created_date");
                    Date dueDate = resultSet.getDate("due_date");
                    String status = resultSet.getString("status");

                    Tasks task = new Tasks(taskId, title, description, createdDate, dueDate, status);
                    tasks.add(task);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }
   public static void doCompleteTask(int taskId, Connection connection) {
    String updateTaskAssignmentSql = "UPDATE TaskAssignments SET complete_date = ? WHERE task_id = ?";
    String updateTaskSql = "UPDATE Tasks SET status = 'completed' WHERE task_id = ?";

    try {
        connection.setAutoCommit(false); // Bắt đầu giao dịch

        // Cập nhật TaskAssignments
        try (PreparedStatement ps1 = connection.prepareStatement(updateTaskAssignmentSql)) {
            ps1.setDate(1, new java.sql.Date(System.currentTimeMillis())); // Lưu ngày hiện tại
            ps1.setInt(2, taskId);
            ps1.executeUpdate();
        }

        // Cập nhật Tasks
        try (PreparedStatement ps2 = connection.prepareStatement(updateTaskSql)) {
            ps2.setInt(1, taskId);
            ps2.executeUpdate();
        }

        connection.commit(); // Cam kết giao dịch
        System.out.println("Task completed successfully.");
    } catch (Exception e) {
        try {
            connection.rollback(); // Hoàn tác nếu có lỗi
            System.err.println("Transaction rolled back due to an error.");
        } catch (Exception rollbackEx) {
            rollbackEx.printStackTrace();
        }
        e.printStackTrace();
    } finally {
        try {
            connection.setAutoCommit(true); // Đặt lại chế độ tự động cam kết
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
   public static boolean registerUser(String username, String password, String email, Connection connection) {
    String sql = "INSERT INTO Users (username, password, email) VALUES (?, ?, ?)";

    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password); // Lưu ý: Nên mã hóa mật khẩu trước khi lưu trữ
        preparedStatement.setString(3, email);
        int rowsAffected = preparedStatement.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("User registered successfully.");
            return true;
        } else {
            System.out.println("Registration failed.");
            return false;
        }
    } catch (Exception e) {
        return false;
    }
}
    

}

