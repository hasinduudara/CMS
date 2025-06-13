<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%
    String username = (String) session.getAttribute("username");
    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
</head>
<body>
<div class="container">
    <h2>Welcome, <%= username %> (Employee)</h2>

    <a href="<%= request.getContextPath() %>/jsp/employee/complaint_form.jsp" class="btn">+ Submit New Complaint</a>

    <h3>My Complaints</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Status</th>
            <th>Submitted</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (complaints != null && !complaints.isEmpty()) {
            for (Complaint c : complaints) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getCreatedAt() %></td>
            <td>
                <% if (!"RESOLVED".equals(c.getStatus())) { %>
                <a href="edit_complaint.jsp?id=<%= c.getId() %>">Edit</a> |
                <a href="../../deleteComplaint?id=<%= c.getId() %>" onclick="return confirm('Delete this complaint?')">Delete</a>
                <% } else { %>
                <span>Locked</span>
                <% } %>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">No complaints submitted.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
