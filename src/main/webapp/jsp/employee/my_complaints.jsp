<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/12/2025
  Time: 10:42 AM
  To change this template use File | Settings | File Templates.
--%>

<%@page session="true" import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>

<%
  List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
%>

<html>
<head>
    <title>My Complaints</title>
</head>
<body>
<div class="container">
  <h2>My Complaints</h2>
  <table>
    <thead>
    <tr>
        <th>Complaint ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (complaints != null) {
        for (Complaint complaint : complaints) {
      }
    %>
    <tr>
    <td><%= complaint.getId() %></td>
    <td><%= complaint.getTitle() %></td>
    <td><%= complaint.getDescription() %></td>
    <td><%= complaint.getStatus() %></td>
    <td>
    <%
        if (!"RESOLVED".equals(complaint.getStatus())) {
    %>
      <a href="../../editComplaint?id=<%= complaint.getId() %>">Edit</a> |
      <a href="../../deleteComplaint?id=<%= complaint.getId() %>">Delete</a>
    <%
        } else {
    %>
      <i>Locked</i>
    <%
        } %>
    </td>
    </tr>
    <% } %>
  </table>
</div>
</body>
</html>
