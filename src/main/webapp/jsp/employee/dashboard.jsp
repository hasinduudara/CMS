<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%
  String username = (String) session.getAttribute("username");
  List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
  String error = request.getParameter("error");
  String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Employee Dashboard - CMS</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employee_dashboard.css">
</head>
<body>
<div class="dashboard-container">
  <div class="header-bar">
    <h2>Welcome, <%= username %> (Employee)</h2>
    <div class="header-actions">
      <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-logout">Logout</a>
    </div>
  </div>

  <% if (success != null) { %>
  <div class="alert alert-success">
    <%= success %>
  </div>
  <% } %>

  <% if (error != null) { %>
  <div class="alert alert-error">
    <%= error %>
  </div>
  <% } %>

  <div class="action-section">
    <a href="${pageContext.request.contextPath}/submitComplaint" class="submit-btn">
      + Submit New Complaint
    </a>
  </div>

  <%
    int totalComplaints = 0;
    int pendingCount = 0;
    int inProgressCount = 0;
    int resolvedCount = 0;

    if (complaints != null) {
      totalComplaints = complaints.size();
      for (Complaint c : complaints) {
        switch (c.getStatus()) {
          case PENDING:
            pendingCount++;
            break;
          case IN_PROGRESS:
            inProgressCount++;
            break;
          case RESOLVED:
            resolvedCount++;
            break;
        }
      }
    }
  %>

  <div class="stats">
    <div class="stat-item">
      <div class="stat-number"><%= totalComplaints %></div>
      <div class="stat-label">Total Complaints</div>
    </div>
    <div class="stat-item">
      <div class="stat-number"><%= pendingCount %></div>
      <div class="stat-label">Pending</div>
    </div>
    <div class="stat-item">
      <div class="stat-number"><%= inProgressCount %></div>
      <div class="stat-label">In Progress</div>
    </div>
    <div class="stat-item">
      <div class="stat-number"><%= resolvedCount %></div>
      <div class="stat-label">Resolved</div>
    </div>
  </div>

  <div class="complaints-section">
    <div class="section-header">
      <h3>My Complaints</h3>
    </div>

    <% if (complaints != null && !complaints.isEmpty()) { %>
    <table class="complaints-table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Title & Description</th>
        <th>Status</th>
        <th>Submitted</th>
        <th>Remark</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <% for (Complaint c : complaints) { %>
      <tr>
        <td><strong>#<%= c.getId() %></strong></td>
        <td>
          <div class="complaint-title"><%= c.getTitle() %></div>
          <div class="complaint-description" title="<%= c.getDescription() %>">
            <%= c.getDescription() %>
          </div>
        </td>
        <td>
        <span class="status-badge status-<%= c.getStatus().toString().toLowerCase() %>">
              <%= c.getStatus() %>
        </span>
        </td>
        <td>
          <div class="date-time">
            <%= c.getCreatedAt().toLocalDate() %><br>
            <small><%= c.getCreatedAt().toLocalTime() %></small>
          </div>
        </td>
        <td>
          <%= c.getRemark() != null && !c.getRemark().trim().isEmpty() ? c.getRemark() : "-" %>
        </td>
        <td>
          <div class="action-buttons">
            <% if (!"RESOLVED".equals(c.getStatus().toString())) { %>
            <a href="${pageContext.request.contextPath}/editComplaint?id=<%= c.getId() %>" class="btn-edit">Edit</a>
            <a href="${pageContext.request.contextPath}/deleteComplaint?id=<%= c.getId() %>"
               class="btn-delete"
               onclick="return confirm('Are you sure you want to delete this complaint?')">Delete</a>
            <% } else { %>
            <span class="btn-locked">Locked</span>
            <% } %>
          </div>
        </td>
      </tr>
      <% } %>
      </tbody>
    </table>
    <% } else { %>
    <div class="no-complaints">
      <i>📝</i>
      <h4>No complaints submitted yet</h4>
      <p>Click the "Submit New Complaint" button above to create your first complaint.</p>
    </div>
    <% } %>
  </div>
</div>
</body>
</html>