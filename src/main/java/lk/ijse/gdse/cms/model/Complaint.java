package lk.ijse.gdse.cms.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Complaint {
    private int id;
    private int userId;
    private String title;
    private String description;
    private String status;
    private String remark;
    private Timestamp complaintTime;

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(ComplaintStatus status) {
        this.status = status.toString();
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.complaintTime = Timestamp.valueOf(createdAt);
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public ComplaintStatus getStatus() {
        return ComplaintStatus.valueOf(status);
    }

    public LocalDateTime getDateSubmitted() {
        return complaintTime.toLocalDateTime();
    }

    public int getUserId() {
        return userId;
    }

    public String getRemark() {
        return remark;
    }

    public LocalDateTime getCreatedAt() {
        return complaintTime.toLocalDateTime();
    }
}