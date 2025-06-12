<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/12/2025
  Time: 12:12 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page session="true" import="lk.ijse.gdse.cms.model.Complaint" %>

<%
    Complaint complaint = (Complaint) request.getAttribute("complaint");
%>

<html>
<head>Edit Complaint</head>
<body>
<div class="container">
    <h2>Edit Complaint</h2>
    <form action="../../updateComplaint" method="post">
        <input type="hidden" name="id" value="<%= complaint.getId() %>"/>
        <label>Title:</label>
        <br>
        <input type="text" name="title" value="<%= complaint.getTitle() %>" required/>
        <br><br>
        <label>Description:</label>
        <br>
        <textarea name="description" rows="5" cols="40" required><%= complaint.getDescription() %></textarea>
        <br>
        <button type="submit">Update</button>
    </form>
</div>
</body>
</html>