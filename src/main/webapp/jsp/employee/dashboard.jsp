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
  <title>Employee Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .dashboard-container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }

    .header-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      padding: 15px 20px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .header-bar h2 {
      margin: 0;
      font-size: 24px;
    }

    .header-actions {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .btn {
      padding: 8px 16px;
      text-decoration: none;
      border-radius: 5px;
      font-size: 14px;
      border: none;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background-color: #28a745;
      color: white;
    }

    .btn-primary:hover {
      background-color: #218838;
      transform: translateY(-1px);
    }

    .btn-logout {
      background-color: #dc3545;
      color: white;
    }

    .btn-logout:hover {
      background-color: #c82333;
    }

    .btn-dashboard {
      background-color: #17a2b8;
      color: white;
    }

    .btn-dashboard:hover {
      background-color: #138496;
    }

    .action-section {
      margin-bottom: 30px;
      text-align: center;
    }

    .submit-btn {
      background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
      color: white;
      padding: 12px 30px;
      font-size: 16px;
      border: none;
      border-radius: 25px;
      text-decoration: none;
      display: inline-block;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
    }

    .complaints-section {
      background: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .section-header {
      background: #f8f9fa;
      padding: 20px;
      border-bottom: 1px solid #dee2e6;
    }

    .section-header h3 {
      margin: 0;
      color: #495057;
      font-size: 20px;
    }

    .stats {
      display: flex;
      justify-content: space-around;
      margin: 20px 0;
      padding: 15px;
      background: #f8f9fa;
      border-radius: 8px;
    }

    .stat-item {
      text-align: center;
    }

    .stat-number {
      font-size: 24px;
      font-weight: bold;
      color: #495057;
    }

    .stat-label {
      font-size: 12px;
      color: #6c757d;
      text-transform: uppercase;
    }

    .complaints-table {
      width: 100%;
      border-collapse: collapse;
    }

    .complaints-table th {
      background-color: #495057;
      color: white;
      padding: 15px;
      text-align: left;
      font-weight: 600;
    }

    .complaints-table td {
      padding: 15px;
      border-bottom: 1px solid #dee2e6;
    }

    .complaints-table tr:hover {
      background-color: #f8f9fa;
    }

    .status-badge {
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
      text-transform: uppercase;
    }

    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }

    .status-in_progress {
      background-color: #cce5ff;
      color: #004085;
    }

    .status-resolved {
      background-color: #d4edda;
      color: #155724;
    }

    .action-buttons {
      display: flex;
      gap: 8px;
    }

    .btn-edit {
      background-color: #007bff;
      color: white;
      padding: 6px 12px;
      border-radius: 4px;
      text-decoration: none;
      font-size: 12px;
    }

    .btn-edit:hover {
      background-color: #0056b3;
    }

    .btn-delete {
      background-color: #dc3545;
      color: white;
      padding: 6px 12px;
      border-radius: 4px;
      text-decoration: none;
      font-size: 12px;
    }

    .btn-delete:hover {
      background-color: #c82333;
    }

    .btn-locked {
      background-color: #6c757d;
      color: white;
      padding: 6px 12px;
      border-radius: 4px;
      font-size: 12px;
    }

    .alert {
      padding: 12px;
      margin-bottom: 20px;
      border-radius: 5px;
    }

    .alert-success {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .alert-error {
      background-color: #f8d7da;
      color: #721c24;
      border: 1px solid #f5c6cb;
    }

    .no-complaints {
      text-align: center;
      padding: 40px;
      color: #6c757d;
    }

    .no-complaints i {
      font-size: 48px;
      margin-bottom: 15px;
      display: block;
    }

    .complaint-title {
      font-weight: 600;
      color: #495057;
    }

    .complaint-description {
      color: #6c757d;
      font-size: 14px;
      max-width: 200px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .date-time {
      color: #6c757d;
      font-size: 13px;
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <div class="header-bar">
    <h2>Welcome, <%= username %> (Employee)</h2>
    <div class="header-actions">
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
    </div>
  </div>

  <!-- Success/Error Messages -->
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

  <!-- Action Section -->
  <div class="action-section">
    <a href="${pageContext.request.contextPath}/submitComplaint" class="submit-btn">
      + Submit New Complaint
    </a>
  </div>

  <!-- Complaints Statistics -->
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

  <!-- Complaints Table -->
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