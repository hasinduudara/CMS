<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.gdse.cms.model.Complaint" %>
<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Complaint Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            margin-top: 10px;
        }

        select, textarea, input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
        }

        textarea {
            height: 100px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Update Complaint Status</h2>

<form method="post" action="${pageContext.request.contextPath}/update-status">
    <input type="hidden" name="id" value="<%= complaint.getId() %>" />

    <p><strong>Title:</strong> <%= complaint.getTitle() %></p>
    <p><strong>Description:</strong> <%= complaint.getDescription() %></p>

    <label for="status">Status:</label>
    <select name="status" id="status">
        <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>PENDING</option>
        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
        <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>RESOLVED</option>
    </select>

    <label for="remark">Remark:</label>
    <textarea name="remark" id="remark"><%= complaint.getRemark() != null ? complaint.getRemark() : "" %></textarea>

    <input type="submit" value="Update" />
</form>

<a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">← Back to Dashboard</a>
</body>
</html>
