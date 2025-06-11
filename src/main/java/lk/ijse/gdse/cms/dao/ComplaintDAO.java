package lk.ijse.gdse.cms.dao;

import lk.ijse.gdse.cms.model.Complaint;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
                complaint.setStatus(resultSet.getString("status"));
                complaint.setRemark(resultSet.getString("remark"));
                complaint.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());
                list.add(complaint);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
