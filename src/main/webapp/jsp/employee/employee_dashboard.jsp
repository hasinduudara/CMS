<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse.cms.model.Complaint" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
    String username = (String) session.getAttribute("username");
    Integer userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/employee_dashboard.css">
</head>
<body>
<div>
    <h2>Welcome, <%= username %>!</h2>

    <!-- Complaint Submission Form -->
    <form action="submit-complaint" method="post">
        <input type="hidden" name="userId" value="<%= userId %>">
        <label>Title</label>
        <input type="text" name="title" required>

        <label>Description</label>
        <textarea name="description" rows="4" required></textarea>

        <button type="submit" class="btn" style="background-color: #007bff;">Submit Complaint</button>
    </form>

    <!-- Submitted Complaints Table -->
    <h4>Your Complaints</h4>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Remark</th>
            <th>Submitted At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (complaints != null && !complaints.isEmpty()) {
            for (Complaint c : complaints) {
                if (c.getUserId() == userId) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDescription() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getRemark() != null ? c.getRemark() : "-" %></td>
            <td><%= c.getCreatedAt() %></td>
            <td>
                <form action="edit-complaint" method="get" style="display:inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button class="btn btn-warning">Edit</button>
                </form>
                <form action="delete-complaint" method="post" style="display:inline">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <button class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                </form>
            </td>
        </tr>
        <%      }
        }
        } else { %>
        <tr><td colspan="7">No complaints submitted.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
