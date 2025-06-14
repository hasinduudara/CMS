<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .form-container {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        .form-actions {
            text-align: center;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }

        .header-bar > div {
            display: flex;
            align-items: center;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header-bar">
        <h2>Submit New Complaint</h2>
        <div>
            <span>Welcome, <%= username %> (Employee)</span>
            <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn">Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
        </div>
    </div>

    <% if (error != null) { %>
    <div class="error-message">
        <%= error %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/submitComplaint" method="post" class="form-container">
        <div class="form-group">
            <label for="title">Complaint Title:</label>
            <input type="text" id="title" name="title" required maxlength="100"
                   placeholder="Enter a brief title for your complaint"
                   value="<%= request.getParameter("title") != null ? request.getParameter("title") : "" %>">
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" required rows="6"
                      placeholder="Provide detailed description of your complaint..."><%= request.getParameter("description") != null ? request.getParameter("description") : "" %></textarea>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Submit Complaint</button>
            <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>