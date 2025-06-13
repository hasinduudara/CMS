package lk.ijse.gdse.cms.dao;

import lk.ijse.gdse.cms.model.Role;
import lk.ijse.gdse.cms.model.User;
import lk.ijse.gdse.cms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public User login(String username, String password){
        User user = null;

        try (Connection connection = DBConnection.getConnection()){
            String sql = "select * from users where username=? and password=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(Role.valueOf(resultSet.getString("role")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return user;
    }

    public boolean register(User user) {
        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole().name());

            int rows = ps.executeUpdate();
            System.out.println("Inserted rows: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.err.println("DB Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}