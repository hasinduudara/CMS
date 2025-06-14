package lk.ijse.gdse.cms.dao;

import lk.ijse.gdse.cms.model.Complaint;
import lk.ijse.gdse.cms.model.ComplaintStatus;
import lk.ijse.gdse.cms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {
    public List<Complaint> getComplaintsByUser(int userId) {
        List<Complaint> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection()){
            String sql = "select * from complaints where user_id=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Complaint complaint = new Complaint();
                complaint.setId(resultSet.getInt("id"));
                complaint.setUserId(resultSet.getInt("user_id"));
                complaint.setTitle(resultSet.getString("title"));
                complaint.setDescription(resultSet.getString("description"));
                complaint.setStatus(ComplaintStatus.valueOf(resultSet.getString("status")));
                complaint.setRemark(resultSet.getString("remark"));
                complaint.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());
                list.add(complaint);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection()){
            String sql = "select * from complaints";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Complaint complaint = new Complaint();
                complaint.setId(resultSet.getInt("id"));
                complaint.setUserId(resultSet.getInt("user_id"));
                complaint.setTitle(resultSet.getString("title"));
                complaint.setDescription(resultSet.getString("description"));
                complaint.setStatus(ComplaintStatus.valueOf(resultSet.getString("status")));
                complaint.setRemark(resultSet.getString("remark"));
                complaint.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());
                list.add(complaint);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public boolean submitComplaint(Complaint complaint) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "INSERT INTO complaints (user_id, title, description, status, created_at) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, complaint.getUserId());
            preparedStatement.setString(2, complaint.getTitle());
            preparedStatement.setString(3, complaint.getDescription());
            preparedStatement.setString(4, complaint.getStatus().toString());
            preparedStatement.setTimestamp(5, Timestamp.valueOf(complaint.getCreatedAt()));

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Failed to submit complaint: " + e.getMessage(), e);
        }
    }
}