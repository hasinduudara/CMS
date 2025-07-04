package lk.ijse.gdse.cms.dao;

import lk.ijse.gdse.cms.model.Complaint;
import lk.ijse.gdse.cms.model.ComplaintStatus;
import lk.ijse.gdse.cms.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public static void updateStatusAndRemark(int id, String status, String remark) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "UPDATE complaints SET status = ?, remark = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, status);
            preparedStatement.setString(2, remark);
            preparedStatement.setInt(3, id);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No complaint found with ID: " + id);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error updating complaint status and remark: " + e.getMessage(), e);
        }
    }

    public List<Complaint> getComplaintsByUser(int userId) {
        List<Complaint> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection()){
            String sql = "SELECT * FROM complaints WHERE user_id = ? ORDER BY created_at DESC";
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
            throw new RuntimeException("Error fetching complaints by user: " + e.getMessage(), e);
        }
        return list;
    }

    public List<Complaint> getAllComplaints() {
        List<Complaint> list = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection()){
            String sql = "SELECT * FROM complaints ORDER BY created_at DESC";
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
            throw new RuntimeException("Error fetching all complaints: " + e.getMessage(), e);
        }
        return list;
    }

    public boolean insertComplaint(Complaint complaint) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "INSERT INTO complaints (user_id, title, description, status) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, complaint.getUserId());
            preparedStatement.setString(2, complaint.getTitle());
            preparedStatement.setString(3, complaint.getDescription());
            preparedStatement.setString(4, complaint.getStatus().toString());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error inserting complaint: " + e.getMessage(), e);
        }
    }

    public static Complaint getComplaintById(int id) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT * FROM complaints WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                Complaint complaint = new Complaint();
                complaint.setId(resultSet.getInt("id"));
                complaint.setUserId(resultSet.getInt("user_id"));
                complaint.setTitle(resultSet.getString("title"));
                complaint.setDescription(resultSet.getString("description"));
                complaint.setStatus(ComplaintStatus.valueOf(resultSet.getString("status")));
                complaint.setRemark(resultSet.getString("remark"));
                complaint.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());
                return complaint;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching complaint by ID: " + e.getMessage(), e);
        }
        return null;
    }

    public boolean updateComplaint(Complaint complaint) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "UPDATE complaints SET title = ?, description = ? WHERE id = ? AND status != 'RESOLVED'";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, complaint.getTitle());
            preparedStatement.setString(2, complaint.getDescription());
            preparedStatement.setInt(3, complaint.getId());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating complaint: " + e.getMessage(), e);
        }
    }

    public boolean deleteComplaint(int id) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "DELETE FROM complaints WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint: " + e.getMessage(), e);
        }
    }

    public boolean canUserModifyComplaint(int complaintId, int userId) {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM complaints WHERE id = ? AND user_id = ? AND status != 'RESOLVED'";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, complaintId);
            preparedStatement.setInt(2, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error checking complaint modification rights: " + e.getMessage(), e);
        }
        return false;
    }
}