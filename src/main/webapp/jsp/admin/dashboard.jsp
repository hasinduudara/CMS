<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%
  String username = (String) session.getAttribute("username");
  List<Complaint> allComplaints = (List<Complaint>) request.getAttribute("allComplaints");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
</head>
<body>
<div class="container">
  <h2>Welcome, <%= username %> (Admin)</h2>

  <h3>All Complaints</h3>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>User ID</th>
      <th>Title</th>
      <th>Status</th>
      <th>Submitted</th>
      <th>Remark</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <% if (allComplaints != null && !allComplaints.isEmpty()) {
      for (Complaint c : allComplaints) { %>
    <tr>
      <td><%= c.getId() %></td>
      <td><%= c.getUserId() %></td>
      <td><%= c.getTitle() %></td>
      <td><%= c.getStatus() %></td>
      <td><%= c.getCreatedAt() %></td>
      <td><%= c.getRemark() != null ? c.getRemark() : "-" %></td>
      <td>
        <a href="update_status.jsp?id=<%= c.getId() %>">Update</a> |
        <a href="../../deleteComplaint?id=<%= c.getId() %>" onclick="return confirm('Delete this complaint?')">Delete</a>
      </td>
    </tr>
    <% }} else { %>
    <tr><td colspan="7">No complaints in system.</td></tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
