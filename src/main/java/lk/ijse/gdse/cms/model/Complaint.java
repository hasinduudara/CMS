package lk.ijse.gdse.cms.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class Complaint {
    private int id;
    private String userId;
    private String title;
    private String description;
    private String status;
    private String remark;
    private Timestamp complaintTime;

    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = String.valueOf(userId);
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.complaintTime = Timestamp.valueOf(createdAt);
    }
}
