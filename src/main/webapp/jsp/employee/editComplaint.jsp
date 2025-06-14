<%@ page session="true" import="lk.ijse.gdse.cms.model.Complaint" %>
<%
    String username = (String) session.getAttribute("username");
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Complaint - CMS</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editComplaint.css">
</head>
<body>
<div class="container">
    <div class="header-bar">
        <h2>Edit Complaint</h2>
        <div class="header-actions">
            <span class="user-info">Welcome, <%= username %> (Employee)</span>
            <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn btn-secondary">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
        </div>
    </div>

    <% if (error != null) { %>
    <div class="alert alert-error">
        <strong>Error:</strong> <%= error %>
    </div>
    <% } %>

    <% if (success != null) { %>
    <div class="alert alert-success">
        <strong>Success:</strong> <%= success %>
    </div>
    <% } %>

    <% if (complaint != null) { %>
    <div class="complaint-info">
        <h3>Complaint Information</h3>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Complaint ID</span>
                <span class="info-value">#<%= complaint.getId() %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Current Status</span>
                <span class="status-badge status-<%= complaint.getStatus().toString().toLowerCase() %>">
                            <%= complaint.getStatus() %>
                        </span>
            </div>
            <div class="info-item">
                <span class="info-label">Submitted Date</span>
                <span class="info-value"><%= complaint.getCreatedAt() %></span>
            </div>
            <% if (complaint.getUpdatedAt()) { %>
            <div class="info-item">
                <span class="info-label">Last Updated</span>
                <span class="info-value"><%= complaint.getUpdatedAt() %></span>
            </div>
            <% } %>
        </div>
        <% if (complaint.getRemark() != null && !complaint.getRemark().trim().isEmpty()) { %>
        <div class="info-item" style="margin-top: 15px;">
            <span class="info-label">Admin Remark</span>
            <span class="info-value"><%= complaint.getRemark() %></span>
        </div>
        <% } %>
    </div>

    <form action="${pageContext.request.contextPath}/editComplaint" method="post" class="form-container" id="editForm">
        <input type="hidden" name="id" value="<%= complaint.getId() %>">

        <div class="form-group">
            <label for="title">Complaint Title *</label>
            <input type="text" id="title" name="title" required maxlength="100"
                   value="<%= complaint.getTitle() %>" placeholder="Enter complaint title">
            <div class="char-counter">
                <span id="titleCounter">0</span>/100 characters
            </div>
        </div>

        <div class="form-group">
            <label for="description">Description *</label>
            <textarea id="description" name="description" required maxlength="1000"
                      placeholder="Describe your complaint in detail..."><%= complaint.getDescription() %></textarea>
            <div class="char-counter">
                <span id="descCounter">0</span>/1000 characters
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary btn-large">
                Update Complaint
            </button>
            <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn btn-secondary btn-large">
                Cancel
            </a>
        </div>
    </form>
    <% } else { %>
    <div class="not-found">
        <h3>Complaint Not Found</h3>
        <p>The complaint you're trying to edit was not found or you don't have permission to edit it.</p>
        <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn btn-primary">
            Back to Dashboard
        </a>
    </div>
    <% } %>
</div>

<script>
    // Character counters
    function updateCharCounter(inputId, counterId, maxLength) {
        const input = document.getElementById(inputId);
        const counter = document.getElementById(counterId);

        function updateCount() {
            const currentLength = input.value.length;
            counter.textContent = currentLength;

            if (currentLength > maxLength * 0.9) {
                counter.style.color = '#dc3545';
            } else if (currentLength > maxLength * 0.7) {
                counter.style.color = '#ffc107';
            } else {
                counter.style.color = '#6c757d';
            }
        }

        input.addEventListener('input', updateCount);
        updateCount(); // Initialize
    }

    // Initialize character counters
    document.addEventListener('DOMContentLoaded', function() {
        updateCharCounter('title', 'titleCounter', 100);
        updateCharCounter('description', 'descCounter', 1000);

        // Form validation
        document.getElementById('editForm').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const description = document.getElementById('description').value.trim();

            if (!title) {
                alert('Please enter a complaint title.');
                e.preventDefault();
                return false;
            }

            if (!description) {
                alert('Please enter a complaint description.');
                e.preventDefault();
                return false;
            }

            if (title.length > 100) {
                alert('Complaint title must not exceed 100 characters.');
                e.preventDefault();
                return false;
            }

            if (description.length > 1000) {
                alert('Complaint description must not exceed 1000 characters.');
                e.preventDefault();
                return false;
            }

            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.textContent = 'Updating...';
        });
    });
</script>
</body>
</html>