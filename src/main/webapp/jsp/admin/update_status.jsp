<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.gdse.cms.model.Complaint" %>
<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Complaint Status</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/update_admin.css">
</head>
<body>

<div class="container">
<h2>Update Complaint Status</h2>

<form method="post" action="${pageContext.request.contextPath}/update-status">
    <input type="hidden" name="id" value="<%= complaint.getId() %>" />

    <div class="complaint-info">
        <p><strong>Title:</strong> <%= complaint.getTitle() %></p>
        <p><strong>Description:</strong> <%= complaint.getDescription() %></p>
    </div>

    <label for="status">Status:</label>

    <select name="status" id="status">
        <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
        <option value="In Progress" <%= "In Progress".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
        <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
    </select>

    <label for="remark">Remark:</label>
    <textarea name="remark" id="remark"><%= complaint.getRemark() != null ? complaint.getRemark() : "" %></textarea>

    <input type="submit" value="Update" />
</form>

<a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">← Back to Dashboard</a>
</div>
</body>
</html>
