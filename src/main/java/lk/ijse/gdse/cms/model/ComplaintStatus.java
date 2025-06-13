package lk.ijse.gdse.cms.model;

public enum ComplaintStatus {
    PENDING,
    IN_PROGRESS,
    RESOLVED;

    @Override
    public String toString() {
        switch (this) {
            case PENDING: return "Pending";
            case IN_PROGRESS: return "In Progress";
            case RESOLVED: return "Resolved";
            default: return "";
        }
    }
}
