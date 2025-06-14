<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint - CMS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/submitComplaint.css">

</head>
<body>
<div class="container">
    <div class="header-bar">
        <h2>Submit New Complaint</h2>
        <div>
            <span>Welcome, <%= username %> (Employee)</span>
            <a href="${pageContext.request.contextPath}/employeeDashboard" class="btn">Back to Dashboard</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-logout">Logout</a>
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