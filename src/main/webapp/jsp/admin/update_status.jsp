<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/12/2025
  Time: 1:07 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page session="true" import="lk.ijse.gdse.cms.model.Complaint" %>

<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>

<html>
<head>
    <title>Update Complaint Status</title>
</head>
<body>
<div class="container">
    <h2>Update Complaint Status</h2>
    <form action="../../adminUpdate" method="post">
        <input type="hidden" name="id" value="<%= complaint.getId() %>">
        <label>Status:</label>
        <br>
        <select name="status">
            <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>PENDING</option>
            <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>IN_PROGRESS</option>
            <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>RESOLVED</option>
        </select>
        <br><br>

        <label>Remarks:</label>
        <br>
        <textarea name="remark"><%= complaint.getRemark() %></textarea>
        <br><br>
        <button type="submit">Save</button>
    </form>
</div>
</body>
</html>