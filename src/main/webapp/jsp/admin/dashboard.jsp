<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%
  String username = (String) session.getAttribute("username");
  List<Complaint> allComplaints = (List<Complaint>) request.getAttribute("allComplaints");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashbord.css">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<div class="header">
  <h1>Welcome, <%= username %> (Admin)</h1>
  <a href="${pageContext.request.contextPath}/index.jsp" class="logout-btn" onclick="return confirm('Are you sure you want to logout?')">
    Logout
  </a>
</div>

<div class="container">
  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-number"><%= allComplaints != null ? allComplaints.size() : 0 %></div>
      <div class="stat-label">Total Complaints</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">
        <%= allComplaints != null ? allComplaints.stream().mapToInt(c -> "Pending".equals(c.getStatus()) ? 1 : 0).sum() : 0 %>
      </div>
      <div class="stat-label">Pending</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">
        <%= allComplaints != null ? allComplaints.stream().mapToInt(c -> "In Progress".equals(c.getStatus()) ? 1 : 0).sum() : 0 %>
      </div>
      <div class="stat-label">In Progress</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">
        <%= allComplaints != null ? allComplaints.stream().mapToInt(c -> "Resolved".equals(c.getStatus()) ? 1 : 0).sum() : 0 %>
      </div>
      <div class="stat-label">Resolved</div>
    </div>
  </div>

  <div class="section">
    <div class="section-header">
      <h2 class="section-title">All Complaints</h2>
    </div>

    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>ID</th>
          <th>User ID</th>
          <th>Title & Description</th>
          <th>Status</th>
          <th>Submitted</th>
          <th>Remark</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (allComplaints != null && !allComplaints.isEmpty()) {
          for (Complaint complaint : allComplaints) { %>
        <tr>
          <td>
            <span class="complaint-id">#<%= complaint.getId() %></span>
          </td>
          <td><%= complaint.getUserId() %></td>
          <td>
            <div class="complaint-title"><%= complaint.getTitle() %></div>
            <div class="complaint-description">
              <%= complaint.getDescription() != null ? (complaint.getDescription().length() > 60 ? complaint.getDescription().substring(0, 60) + "..." : complaint.getDescription()) : "No description" %>
            </div>
          </td>
          <td>
            <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace(" ", "-") %>">
              <%= complaint.getStatus() %>
            </span>
          </td>
          <td>
            <div class="date-time">
              <%= complaint.getCreatedAt() %>
            </div>
          </td>
          <td>
            <span class="remark-text">
              <%= complaint.getRemark() != null ? complaint.getRemark() : "-" %>
            </span>
          </td>

          <td>
            <div class="actions">
              <a href="<%= request.getContextPath() %>/update-status?id=<%= complaint.getId() %>" class="btn btn-edit">Edit</a>

              <form method="get" action="<%= request.getContextPath() %>/confirm-delete-complaint" style="display:inline;">
                <input type="hidden" name="id" value="<%= complaint.getId() %>">
                <button type="submit" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this?')">Delete</button>
              </form>
            </div>
          </td>

        </tr>
        <% }} else { %>
        <tr>
          <td colspan="7" class="no-data">No complaints in system.</td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</body>
</html>
