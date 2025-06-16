<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.gdse.cms.model.Complaint" %>
<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Complaint</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_delete.css">
</head>
<body>

<h2 class="danger">Confirm Complaint Deletion</h2>

<p>Are you sure you want to delete this complaint?</p>

<p><strong>Title:</strong> <%= complaint.getTitle() %></p>
<p><strong>Description:</strong> <%= complaint.getDescription() %></p>

<form method="post" action="${pageContext.request.contextPath}/confirm-delete-complaint">
    <input type="hidden" name="id" value="<%= complaint.getId() %>">
    <button type="submit">Yes, Delete</button>
    <a href="/jsp/admin/dashboard.jsp"><button type="button">Cancel</button></a>
</form>

</body>
</html>
