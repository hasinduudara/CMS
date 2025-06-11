<%--
  Created by IntelliJ IDEA.
  User: hasid
  Date: 6/11/2025
  Time: 9:13 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page session="true" %>
<%@page import="java.util.*, lk.ijse.gdse.cms.model.Complaint" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String username = (String) session.getAttribute("username");
  List<Complaint> complaintList = (List<Complaint>) request.getAttribute("complaints");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Dashboard</title>
</head>
<body>
<div class="container">
  <h1>Welcome, <%= username %>!</h1>

  <a href="employee/complaint_form.jsp" class="btn">Submit New Complaint</a>
  <hr>

    <h2>Your Complaints</h2>

  <table>
    <thead>
    <tr>
        <th>Complaint ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Date Submitted</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (complaintList != null && !complaintList.isEmpty()) {
          for (Complaint complaint : complaintList) {
    %>
    <tr>
      <td><%= complaint.getId() %></td>
        <td><%= complaint.getTitle() %></td>
        <td><%= complaint.getDescription() %></td>
        <td><%= complaint.getStatus() %></td>
        <td><%= complaint.getDateSubmitted() %></td>
        <td>
          <% if (!"RESOLVED".equals(complaint.getStatus())) { %>
          <a href="editComplaint?id=<%= complaint.getId() %>">Edit</a> |
          <a href="deleteComplaint?id=<%= complaint.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
            <% } else { %>
            <span>Locked</span>
            <% } %>
        </td>
    </tr>
    <%
          }
    } else {
    %>
    <tr>
    <tr><td colspan="5">No complaints submitted yet.</td></tr>
    </tr>
    <%
          }
    %>
    </tbody>
  </table>
</div>
</body>
</html>
