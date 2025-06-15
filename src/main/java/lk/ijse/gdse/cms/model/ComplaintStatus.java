package lk.ijse.gdse.cms.model;

public enum ComplaintStatus {
    PENDING("PENDING"),
    IN_PROGRESS("IN_PROGRESS"),
    RESOLVED("RESOLVED");

    private final String value;

    ComplaintStatus(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value;
    }

    public static ComplaintStatus fromString(String status) {
        for (ComplaintStatus cs : ComplaintStatus.values()) {
            if (cs.value.equalsIgnoreCase(status)) {
                return cs;
            }
        }
        throw new IllegalArgumentException("Unknown status: " + status);
    }

    public String toLowerCase() {
        return value.toLowerCase();
    }
}