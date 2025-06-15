<%@ page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%
  String username = (String) session.getAttribute("username");
  List<Complaint> allComplaints = (List<Complaint>) request.getAttribute("allComplaints");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      background-color: #f5f5f5;
      min-height: 100vh;
    }

    .header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .header h1 {
      font-size: 24px;
      font-weight: 400;
      margin: 0;
    }

    .logout-btn {
      background-color: #dc3545;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      text-decoration: none;
      font-size: 14px;
      font-weight: 500;
      transition: background-color 0.2s ease;
      display: inline-block;
    }

    .logout-btn:hover {
      background-color: #c82333;
    }

    .container {
      max-width: 1400px;
      margin: 0 auto;
      padding: 40px 20px;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 30px;
      margin-bottom: 40px;
    }

    .stat-card {
      background: white;
      text-align: center;
      padding: 40px 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .stat-number {
      font-size: 48px;
      font-weight: 300;
      color: #333;
      margin-bottom: 8px;
      line-height: 1;
    }

    .stat-label {
      font-size: 14px;
      color: #666;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      font-weight: 500;
    }

    .section {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .section-header {
      padding: 24px 32px;
      border-bottom: 1px solid #e9ecef;
    }

    .section-title {
      font-size: 20px;
      font-weight: 500;
      color: #333;
      margin: 0;
    }

    .table-container {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    thead {
      background-color: #495057;
    }

    th {
      color: white;
      font-weight: 500;
      font-size: 14px;
      padding: 16px 20px;
      text-align: left;
      border: none;
    }

    tbody tr {
      border-bottom: 1px solid #e9ecef;
      transition: background-color 0.2s ease;
    }

    tbody tr:hover {
      background-color: #f8f9fa;
    }

    td {
      padding: 20px;
      color: #333;
      font-size: 14px;
      vertical-align: middle;
    }

    .complaint-id {
      font-weight: 600;
      color: #333;
    }

    .complaint-title {
      font-weight: 500;
      color: #333;
      margin-bottom: 4px;
    }

    .complaint-description {
      color: #666;
      font-size: 13px;
      line-height: 1.4;
    }

    .status-badge {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 11px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }

    .status-in-progress {
      background-color: #cce5ff;
      color: #0066cc;
    }

    .status-resolved {
      background-color: #d4edda;
      color: #155724;
    }

    .status-closed {
      background-color: #f8d7da;
      color: #721c24;
    }

    .date-time {
      color: #666;
      font-size: 13px;
    }

    .actions {
      display: flex;
      gap: 8px;
    }

    .btn {
      padding: 8px 16px;
      border-radius: 4px;
      text-decoration: none;
      font-size: 12px;
      font-weight: 500;
      border: none;
      cursor: pointer;
      transition: all 0.2s ease;
      text-align: center;
      display: inline-block;
    }

    .btn-edit {
      background-color: #007bff;
      color: white;
    }

    .btn-edit:hover {
      background-color: #0056b3;
    }

    .btn-delete {
      background-color: #dc3545;
      color: white;
    }

    .btn-delete:hover {
      background-color: #c82333;
    }

    .no-data {
      text-align: center;
      padding: 60px 20px;
      color: #666;
      font-size: 16px;
    }

    .remark-text {
      color: #666;
      font-style: italic;
    }

    @media (max-width: 768px) {
      .header {
        padding: 15px 20px;
      }

      .header h1 {
        font-size: 20px;
      }

      .container {
        padding: 20px 15px;
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
      }

      .stat-card {
        padding: 25px 15px;
      }

      .stat-number {
        font-size: 36px;
      }

      .section-header {
        padding: 20px;
      }

      th, td {
        padding: 12px 15px;
        font-size: 13px;
      }

      .actions {
        flex-direction: column;
        gap: 5px;
      }

      .btn {
        font-size: 11px;
        padding: 6px 12px;
      }
    }
  </style>
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
          for (Complaint c : allComplaints) { %>
        <tr>
          <td>
            <span class="complaint-id">#<%= c.getId() %></span>
          </td>
          <td><%= c.getUserId() %></td>
          <td>
            <div class="complaint-title"><%= c.getTitle() %></div>
            <div class="complaint-description">
              <%= c.getDescription() != null ? (c.getDescription().length() > 60 ? c.getDescription().substring(0, 60) + "..." : c.getDescription()) : "No description" %>
            </div>
          </td>
          <td>
                <span class="status-badge status-<%= c.getStatus().toLowerCase().replace(" ", "-") %>">
                  <%= c.getStatus() %>
                </span>
          </td>
          <td>
            <div class="date-time">
              <%= c.getCreatedAt() %>
            </div>
          </td>
          <td>
                <span class="remark-text">
                  <%= c.getRemark() != null ? c.getRemark() : "-" %>
                </span>
          </td>
          <td>
            <div class="actions">
              <a href="<%= request.getContextPath() %>/update-status?id=<%= c.getId() %>" class="btn btn-edit">Edit</a>
              <a href="../../deleteComplaint?id=<%= c.getId() %>" class="btn btn-delete" onclick="return confirm('Delete this complaint?')">Delete</a>
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